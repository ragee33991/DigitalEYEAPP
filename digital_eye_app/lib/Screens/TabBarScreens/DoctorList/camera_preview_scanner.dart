// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:ui' show lerpDouble;
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'colors.dart';
import 'scanner_utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:ui' as ui;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:digital_eye_app/pages/result.dart' as R;

enum AnimationState { search, barcodeNear, barcodeFound, endSearch }
var postleft = 50.0;
var posttop = 139.75;
var postright = 361.45;
var postbottom = 259.10;
bool doesContain = false;

class CameraPreviewScanner extends StatefulWidget {
  const CameraPreviewScanner({
    this.validRectangle = const Rectangle(width: 350, height: 100),
    this.frameColor = kShrineScrim,
    this.traceMultiplier = 1.2,
  });

  final Rectangle validRectangle;
  final Color frameColor;
  final double traceMultiplier;

  @override
  _CameraPreviewScannerState createState() => _CameraPreviewScannerState();
}

class _CameraPreviewScannerState extends State<CameraPreviewScanner>
    with TickerProviderStateMixin {
  double progressValue = 0;
  Timer _timer;

  CameraController _cameraController;
  AnimationController _animationController;
  String _scannerHint;

  bool _closeWindow = false;
  String _barcodePictureFilePath;
  Size _previewSize;
  AnimationState _currentState = AnimationState.search;
  CustomPainter _animationPainter;
  int _animationStart = DateTime.now().millisecondsSinceEpoch;
  final FaceDetector _faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
          mode: FaceDetectorMode.accurate,
          enableLandmarks: true,
          enableClassification: true,
          enableContours: true,
          enableTracking: true));
  dynamic _scanResults;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[]);
    SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp],
    );
    _initCameraAndScanner();
    _switchAnimationState(AnimationState.search);
  }

  void _initCameraAndScanner() {
    ScannerUtils.getCamera(CameraLensDirection.front).then(
      (CameraDescription camera) async {
        await _openCamera(camera);
        await _startStreamingImagesToScanner(camera.sensorOrientation);
      },
    );
  }

  void _initAnimation(Duration duration) {
    setState(() {
      progressValue++;
      if (progressValue == 100) {
        _timer.cancel();
      }

      _animationPainter = null;
    });

    _animationController?.dispose();
    _animationController = AnimationController(duration: duration, vsync: this);
  }

  void _switchAnimationState(AnimationState newState) {
    if (newState == AnimationState.search) {
      _initAnimation(const Duration(seconds: 750));

      _animationPainter = RectangleOutlinePainter(
        animation: RectangleTween(
          Rectangle(
            width: widget.validRectangle.width,
            height: widget.validRectangle.height,
            color: Colors.white,
          ),
          Rectangle(
            width: widget.validRectangle.width * widget.traceMultiplier,
            height: widget.validRectangle.height * widget.traceMultiplier,
            color: Colors.transparent,
          ),
        ).animate(_animationController),
      );

      _animationController.addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          Future<void>.delayed(const Duration(milliseconds: 1600), () {
            if (_currentState == AnimationState.search) {
              _animationController.forward(from: 0);
            }
          });
        }
      });
    } else if (newState == AnimationState.barcodeNear ||
        newState == AnimationState.barcodeFound ||
        newState == AnimationState.endSearch) {
      double begin;
      if (_currentState == AnimationState.barcodeNear) {
        begin = lerpDouble(0.0, 0.5, _animationController.value);
      } else if (_currentState == AnimationState.search) {
        _initAnimation(const Duration(milliseconds: 500));
        begin = 0.0;
      }

      _animationPainter = RectangleTracePainter(
        rectangle: Rectangle(
          width: widget.validRectangle.width,
          height: widget.validRectangle.height,
          color: newState == AnimationState.endSearch
              ? Colors.transparent
              : Colors.white,
        ),
        animation: Tween<double>(
          begin: begin,
          end: newState == AnimationState.barcodeNear ? 0.5 : 1.0,
        ).animate(_animationController),
      );

      if (newState == AnimationState.barcodeFound) {
        _animationController.addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            Future<void>.delayed(const Duration(milliseconds: 300), () {
              if (_currentState != AnimationState.endSearch) {
                _switchAnimationState(AnimationState.endSearch);
                setState(() {});
                // _showBottomSheet()
                ;
              }
            });
          }
        });
      }
    }

    _currentState = newState;
    if (newState != AnimationState.endSearch) {
      _animationController.forward(from: 0);
      _animationStart = DateTime.now().millisecondsSinceEpoch;
    }
  }

  Future<void> _openCamera(CameraDescription camera) async {
    final ResolutionPreset preset =
        defaultTargetPlatform == TargetPlatform.android
            ? ResolutionPreset.veryHigh
            : ResolutionPreset.veryHigh;

    _cameraController = CameraController(camera, preset);
    await _cameraController.initialize();
    _previewSize = _cameraController.value.previewSize;
    setState(() {});
  }

  Future<void> _startStreamingImagesToScanner(int sensorOrientation) async {
    bool isDetecting = false;
    final MediaQueryData data = MediaQuery.of(context);

    _cameraController.startImageStream((CameraImage image) {
      if (isDetecting) {
        return;
      }

      isDetecting = true;

      ScannerUtils.detect(
        image: image,
        detectInImage: _faceDetector.processImage,
        imageRotation: sensorOrientation,
      ).then(
        (dynamic result) {
          _handleResult(
            faces: result,
            data: data,
            imageSize: Size(image.width.toDouble(), image.height.toDouble()),
          );
          setState(() {
            _scanResults = result;
          });
        },
      ).whenComplete(() => isDetecting = false);
    });
  }

  bool get _barcodeNearAnimationInProgress {
    return _currentState == AnimationState.barcodeNear &&
        DateTime.now().millisecondsSinceEpoch - _animationStart < 2500;
  }

  void _handleResult({
    @required List<Face> faces,
    @required MediaQueryData data,
    @required Size imageSize,
  }) {
    if (!_cameraController.value.isStreamingImages) {
      return;
    }

    final EdgeInsets padding = data.padding;
    final double maxLogicalHeight =
        data.size.height - padding.top - padding.bottom;

    // Width & height are flipped from CameraController.previewSize on iOS
    final double imageHeight = defaultTargetPlatform == TargetPlatform.iOS
        ? imageSize.height
        : imageSize.width;

    final double imageScale = imageHeight / maxLogicalHeight;
    final double halfWidth = imageScale * widget.validRectangle.width / 2;
    final double halfHeight = imageScale * widget.validRectangle.height / 2;

    final double scaleX = halfWidth / imageSize.width;
    final double scaleY = halfHeight / imageSize.height;

    final Offset center = imageSize.topCenter(Offset(0, 160));
    final Rect validRect = Rect.fromLTRB(
      center.dx - halfWidth,
      center.dy - halfHeight,
      center.dx + halfWidth,
      center.dy + halfHeight,
    );

    for (Face face in faces) {
      Rect rect = Rect.fromLTRB(
        face.getLandmark(FaceLandmarkType.leftEye).position.dx - 200,
        face.getContour(FaceContourType.leftEyebrowTop).positionsList[0].dy -
            200,
        face.getLandmark(FaceLandmarkType.rightEye).position.dx - 200,
        face.getLandmark(FaceLandmarkType.leftEye).position.dy - 200,
      );

      final userwidth = 440;

      double left = face.getLandmark(FaceLandmarkType.leftEye).position.dx;
      double top =
          face.getContour(FaceContourType.leftEyebrowTop).positionsList[0].dy;
      double width = face.getLandmark(FaceLandmarkType.rightEar).position.dx;
      double height = face.getLandmark(FaceLandmarkType.leftEye).position.dy;

      bool rectTop = validRect.contains(rect.topLeft);
      bool rectbottom = validRect.contains(rect.bottomRight);
      bool rectcenter = validRect.contains(rect.center);
      bool rectwidth = rect.width > userwidth;
      bool rectheight = rect.height > userwidth;

      final Rect intersection = validRect.intersect(rect);

      //final bool doesContain = intersection == rect;

      if (rectTop) {
        print("rectTop");
        if (rectbottom) {
          print("rectbottom");
          if (rectcenter) {
            print("rectcenter");
            if (rectwidth) {
              print("rectwidth");
              if (face.rightEyeOpenProbability != null &&
                  face.leftEyeOpenProbability != null) {
                if (face.rightEyeOpenProbability > 0.08 &&
                    face.leftEyeOpenProbability > 0.08) {
                  doesContain = true;

                  if (doesContain) {
                    if (_currentState != AnimationState.barcodeFound) {
                      if (_currentState != AnimationState.barcodeFound) {
                        _cameraController.stopImageStream().then((_) =>
                            _takePicture(left.toInt(), top.toInt(),
                                width.toInt(), height.toInt()));
                        _closeWindow = true;
                        _scannerHint = 'Loading ...';
                        _switchAnimationState(AnimationState.barcodeFound);
                        if (rectTop == false) {
                          _scannerHint = 'Move to the Scanner';
                        }
                        if (rectbottom == false) {
                          _scannerHint = 'Move to the Scanner';
                        }
                        if (rectcenter == false) {
                          _scannerHint = 'Move  to the Scanner';
                        }
                        if (rect.width > userwidth) {
                          _scannerHint = 'Move closer to the Scanner';
                        }
                        if (rect.width < userwidth) {
                          _scannerHint = 'Move further  from the Scanner';
                        }
                        /*
                
               

                    */
                        setState(() {
                          progressValue++;
                        });
                      }
                    } else
                      _scannerHint = 'Open your Eyes Wider ...';
                  } else if (_currentState != AnimationState.barcodeNear) {
                    _scannerHint = 'Move further from to the Scanner';
                    // _switchAnimationState(AnimationState.barcodeNear);
                    setState(() {});
                  }
                }
              }
            }
          }
        }
        return;
      } else if (rect.overlaps(validRect)) {
        if (_currentState != AnimationState.barcodeNear) {
          _scannerHint = 'Move closer to the Scanner';
          // _switchAnimationState(AnimationState.barcodeNear);
          setState(() {});
        }

        return;
      }
    }

/*
    if (_barcodeNearAnimationInProgress) {
      return;
    }
    */

    if (_currentState != AnimationState.search) {
      _scannerHint = null;
      _switchAnimationState(AnimationState.search);
      setState(() {});
    }
  }

  @override
  void dispose() {
    _currentState = AnimationState.endSearch;
    _cameraController?.stopImageStream();
    _cameraController?.dispose();
    _animationController?.dispose();
    _faceDetector.close();

    SystemChrome.setPreferredOrientations(<DeviceOrientation>[]);
    SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);

    super.dispose();
  }

  Future<void> _takePicture(int dx, int dy, int width, int height) async {
    final Directory extDir = await getApplicationDocumentsDirectory();

    final String dirPath = '${extDir.path}/Pictures/barcodePics';
    await Directory(dirPath).create(recursive: true);

    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    final String filePath = '$dirPath/$timestamp.jpg';

    setState(() {
      _animationPainter = null;
    });

    try {
      await _cameraController.takePicture(filePath);
    } on CameraException catch (e) {
      print(e);
    }

    while (progressValue < 99) {
      progressValue++;
    }
    setState(() {
      if (progressValue == 100) {
        _timer.cancel();
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => R.Results(),
          ));

      _barcodePictureFilePath = filePath;
    });

    File imgFile = new File(filePath);

    print(filePath);
    print(dx);
    print(dy);
    print(width);
    print(height);

/*
    File croppedFile =
        await FlutterNativeImage.cropImage(imgFile.path, dx, dy, width, height);
    handleTaskExample2(croppedFile.path);
     */
    _cameraController.dispose();
    _cameraController = null;
  }

  Widget _buildCameraPreview() {
    return Container(
      color: Colors.black,
      child: Transform.scale(
        scale: _getImageZoom(MediaQuery.of(context)),
        child: Center(
          child: AspectRatio(
            aspectRatio: _cameraController.value.aspectRatio,
            child: CameraPreview(_cameraController),
          ),
        ),
      ),
    );
  }

  Future<void> handleTaskExample2(String filePath) async {
    print("hello");
    File largeFile = File(filePath);
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(RouterName.id)
        .child('$timestamp.jpg')
        .putFile(largeFile);

    task.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
      print('Task state: ${snapshot.state}');
      print(
          'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');

      setState(() {
        progressValue =
            ((snapshot.bytesTransferred / snapshot.totalBytes) * 100)
                .toDouble();
      });
    }, onError: (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
      print(task.snapshot);

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    });

    // We can still optionally use the Future alongside the stream.
    try {
      await task;
      print('Upload complete.');
    } on firebase_core.FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
      // ...
    }
  }

  double _getImageZoom(MediaQueryData data) {
    final double logicalWidth = data.size.width;
    final double logicalHeight = _previewSize.aspectRatio * logicalWidth;

    final EdgeInsets padding = data.padding;
    final double maxLogicalHeight =
        data.size.height - padding.top - padding.bottom;

    return maxLogicalHeight / logicalHeight;
  }

  void _reset() {
    _initCameraAndScanner();
    setState(() {
      _closeWindow = false;
      _barcodePictureFilePath = null;
      _scannerHint = null;
      _switchAnimationState(AnimationState.search);
    });
  }

  Size imageSize;
  @override
  Widget build(BuildContext context) {
    Widget background;
    if (_barcodePictureFilePath != null) {
      background = Container(
        color: Colors.black,
        child: Transform.scale(
          scale: _getImageZoom(MediaQuery.of(context)),
          child: Center(
            child: Image.file(
              File(_barcodePictureFilePath),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      );
    } else if (_cameraController != null &&
        _cameraController.value.isInitialized) {
      imageSize = Size(
        _cameraController.value.previewSize.height,
        _cameraController.value.previewSize.width,
      );

      background = _buildCameraPreview();
    } else {
      background = Container(
        color: Colors.black,
      );
    }
    double screenHeight = MediaQuery.of(context).size.height;

    /// Returns gradient progress style circular progress bar.
    Widget getGradientProgressStyle() {
      return Container(
          height: 120,
          width: 120,
          child: SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                radiusFactor: 0.8,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.1,
                  color: const Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                  cornerStyle: CornerStyle.startCurve,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                      value: progressValue,
                      width: 0.1,
                      sizeUnit: GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 100,
                      animationType: AnimationType.linear,
                      cornerStyle: CornerStyle.startCurve,
                      gradient: const SweepGradient(
                          colors: <Color>[Color(0xFF00a9b5), Color(0xFFa4edeb)],
                          stops: <double>[0.25, 0.75])),
                  MarkerPointer(
                    value: progressValue,
                    markerType: MarkerType.circle,
                    enableAnimation: true,
                    animationDuration: 100,
                    animationType: AnimationType.linear,
                    color: const Color(0xFF87e8e8),
                  )
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      positionFactor: 0,
                      widget: Text(progressValue.toStringAsFixed(0) + '%'))
                ]),
          ]));
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            background,
            Container(
              constraints: const BoxConstraints.expand(),
              child: CustomPaint(
                painter: WindowPainter(
                  imageSize: imageSize,
                  faces: _scanResults,
                  windowSize: Size(widget.validRectangle.width,
                      widget.validRectangle.height),
                  outerFrameColor: widget.frameColor,
                  closeWindow: _closeWindow,
                  innerFrameColor: _currentState == AnimationState.endSearch
                      ? Colors.transparent
                      : kShrineFrameBrown,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const <Color>[Colors.black87, Colors.black87],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              right: 0.0,
              //change the size of the container
              height: screenHeight / 1.7,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: Center(
                    child: Column(
                      children: [
                        getGradientProgressStyle(),
                        Text(
                          _scannerHint ?? 'Scan your Eyes',
                          style: Theme.of(context).textTheme.button,
                          textScaleFactor: 1.3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints.expand(),
              child: CustomPaint(
                painter: _animationPainter,
              ),
            ),
            AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
          ],
        ),
      ),
    );
  }
}

CameraLensDirection cameraLensDirection;

class WindowPainter extends CustomPainter {
  WindowPainter({
    @required this.windowSize,
    this.outerFrameColor = Colors.white54,
    this.innerFrameColor = const Color(0xFF442C2E),
    this.innerFrameStrokeWidth = 3,
    this.closeWindow = false,
    this.faces,
    this.imageSize,
  });

  final Size windowSize;
  final Color outerFrameColor;
  final Color innerFrameColor;
  final double innerFrameStrokeWidth;
  final bool closeWindow;
  final List<Face> faces;
  final Size imageSize;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.topCenter(Offset(0, 160));
    final double windowHalfWidth = windowSize.width / 2;
    final double windowHalfHeight = windowSize.height / 2;
    final double scaleX = size.width / imageSize.width;
    final double scaleY = size.height / imageSize.height;

    final Rect windowRect = Rect.fromLTRB(
      center.dx - windowHalfWidth,
      center.dy - windowHalfHeight,
      center.dx + windowHalfWidth,
      center.dy + windowHalfHeight,
    );

    final Rect left =
        Rect.fromLTRB(0, windowRect.top, windowRect.left, windowRect.bottom);
    final Rect top = Rect.fromLTRB(0, 0, size.width, windowRect.top);
    final Rect right = Rect.fromLTRB(
      windowRect.right,
      windowRect.top,
      size.width,
      windowRect.bottom,
    );
    final Rect bottom = Rect.fromLTRB(
      0,
      windowRect.bottom,
      size.width,
      size.height,
    );
    final Paint paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;

    final Paint paint3 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.blue;
    //  face.getLandmark(FaceLandmarkType.leftEye).position.distance * scaleX,

    final ui.ParagraphBuilder builder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontSize: 23.0,
          textDirection: TextDirection.ltr),
    );

    builder.pushStyle(ui.TextStyle(color: Colors.white));
    for (Face face in faces) {
      //0 eyes are closed 1 eyes are open
      if (face.rightEyeOpenProbability != null) {
        builder.addText(
            'rightEye: ${face.rightEyeOpenProbability.toStringAsFixed(2)}\n');
      }
      if (face.leftEyeOpenProbability != null) {
        builder.addText(
            'leftEye: ${face.leftEyeOpenProbability.toStringAsFixed(2)}\n');
      }

      // var ff= (face.getLandmark(FaceLandmarkType.noseBase).position.dy * scaleY)/2,

      canvas.drawRect(
        Rect.fromLTRB(
          face.getLandmark(FaceLandmarkType.leftEar).position.dx * scaleX,
          face.getContour(FaceContourType.leftEyebrowTop).positionsList[0].dy *
              scaleY,
          face.getLandmark(FaceLandmarkType.rightEar).position.dx * scaleX,
          (face.getLandmark(FaceLandmarkType.noseBase).position.dy * scaleY) /
              1.2,
        ),
        paint2,
      );

      var rect = Rect.fromLTRB(
        face.getLandmark(FaceLandmarkType.leftEar).position.dx * scaleX,
        face.getContour(FaceContourType.leftEyebrowTop).positionsList[0].dy *
            scaleY,
        face.getLandmark(FaceLandmarkType.rightEar).position.dx * scaleX,
        (face.getLandmark(FaceLandmarkType.noseBase).position.dy * scaleY) /
            1.2,
      );

      var validRect = Rect.fromLTRB(postleft, posttop, postright, postbottom);

      final Rect intersection = validRect.intersect(rect);
      final bool doesContains = intersection == rect && rect.height > 80;
      final bool height = rect.height > 80;

      if (doesContains) {
        doesContain = false;
      }

      builder.pop();
      canvas.drawParagraph(
        builder.build()
          ..layout(ui.ParagraphConstraints(
            width: size.width,
          )),
        const Offset(0.0, 0.0),
      );

      canvas.drawRect(
          windowRect,
          Paint()
            ..color = innerFrameColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = innerFrameStrokeWidth);

      final Paint paint = Paint()..color = outerFrameColor;
      canvas.drawRect(left, paint);
      canvas.drawRect(top, paint);
      canvas.drawRect(right, paint);
      canvas.drawRect(bottom, paint);

      if (closeWindow) {
        canvas.drawRect(windowRect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(WindowPainter oldDelegate) =>
      oldDelegate.closeWindow != closeWindow;
}

List<Offset> _scalePoints({
  List<Offset> offsets,
  @required Size imageSize,
  @required Size widgetSize,
}) {
  final double scaleX = widgetSize.width / imageSize.width;
  final double scaleY = widgetSize.height / imageSize.height;

  if (cameraLensDirection == CameraLensDirection.front) {
    return offsets
        .map((offset) =>
            Offset(widgetSize.width - (offset.dx * scaleX), offset.dy * scaleY))
        .toList();
  }
  return offsets
      .map((offset) => Offset(offset.dx * scaleX, offset.dy * scaleY))
      .toList();
}

class Rectangle {
  const Rectangle({this.width, this.height, this.color});

  final double width;
  final double height;
  final Color color;

  static Rectangle lerp(Rectangle begin, Rectangle end, double t) {
    Color color;
    if (t > .5) {
      color = Color.lerp(begin.color, end.color, (t - .5) / .25);
    } else {
      color = begin.color;
    }

    return Rectangle(
      width: lerpDouble(begin.width, end.width, t),
      height: lerpDouble(begin.height, end.height, t),
      color: color,
    );
  }
}

class RectangleTween extends Tween<Rectangle> {
  RectangleTween(Rectangle begin, Rectangle end)
      : super(begin: begin, end: end);

  @override
  Rectangle lerp(double t) => Rectangle.lerp(begin, end, t);
}

class RectangleOutlinePainter extends CustomPainter {
  RectangleOutlinePainter({
    @required this.animation,
    this.strokeWidth = 3,
  }) : super(repaint: animation);

  final Animation<Rectangle> animation;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Rectangle rectangle = animation.value;

    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = rectangle.color
      ..style = PaintingStyle.stroke;

    final Offset center = size.topCenter(Offset(0, 160));
    final double halfWidth = rectangle.width / 2;
    final double halfHeight = rectangle.height / 2;

    final Rect rect = Rect.fromLTRB(
      center.dx - halfWidth,
      center.dy - halfHeight,
      center.dx + halfWidth,
      center.dy + halfHeight,
    );

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(RectangleOutlinePainter oldDelegate) => false;
}

class RectangleTracePainter extends CustomPainter {
  RectangleTracePainter({
    @required this.animation,
    @required this.rectangle,
    this.strokeWidth = 3,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Rectangle rectangle;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final double value = animation.value;

    final Offset center = size.topCenter(Offset(0, 160));
    final double halfWidth = rectangle.width / 2;
    final double halfHeight = rectangle.height / 2;

    final Rect rect = Rect.fromLTRB(
      center.dx - halfWidth,
      center.dy - halfHeight,
      center.dx + halfWidth,
      center.dy + halfHeight,
    );

    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = rectangle.color;

    final double halfStrokeWidth = strokeWidth / 2;

    final double heightProportion = (halfStrokeWidth + rect.height) * value;
    final double widthProportion = (halfStrokeWidth + rect.width) * value;

    canvas.drawLine(
      Offset(rect.right, rect.bottom + halfStrokeWidth),
      Offset(rect.right, rect.bottom - heightProportion),
      paint,
    );

    canvas.drawLine(
      Offset(rect.right + halfStrokeWidth, rect.bottom),
      Offset(rect.right - widthProportion, rect.bottom),
      paint,
    );

    canvas.drawLine(
      Offset(rect.left, rect.top - halfStrokeWidth),
      Offset(rect.left, rect.top + heightProportion),
      paint,
    );

    canvas.drawLine(
      Offset(rect.left - halfStrokeWidth, rect.top),
      Offset(rect.left + widthProportion, rect.top),
      paint,
    );
  }

  @override
  bool shouldRepaint(RectangleTracePainter oldDelegate) => false;
}
