import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'camera_preview_scanner.dart';
import 'firebase_ml_vision.dart';


const size = 200.0;
enum Detector {
  barcode,
  face,
  label,
  cloudLabel,
  text,
  cloudText,
  cloudDocumentText
}

class BarcodeDetectorPainter extends CustomPainter {
  BarcodeDetectorPainter(this.absoluteImageSize, this.barcodeLocations);

  final Size absoluteImageSize;
  final List<Barcode> barcodeLocations;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    Rect scaleRect(Barcode barcode) {
      return Rect.fromLTRB(
        barcode.boundingBox.left * scaleX,
        barcode.boundingBox.top * scaleY,
        barcode.boundingBox.right * scaleX,
        barcode.boundingBox.bottom * scaleY,
      );
    }

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (Barcode barcode in barcodeLocations) {
      paint.color = Colors.green;
      canvas.drawRect(scaleRect(barcode), paint);
    }
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodeLocations != barcodeLocations;
  }
}
CameraLensDirection cameraLensDirection;
ui.Rect rect;



class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.absoluteImageSize, this.faces);

  final Size absoluteImageSize;
  final List<Face> faces;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;

    for (var i = 0; i < faces.length; i++) {
      final List<Offset> facePoints =
          faces[i]
              .getContour(FaceContourType.face)
              .positionsList;

      final List<Offset> leftEyebrowBottom =
          faces[i]
              .getContour(FaceContourType.leftEyebrowBottom)
              .positionsList;
      final List<Offset> leftEyebrowTop =
          faces[i]
              .getContour(FaceContourType.leftEyebrowTop)
              .positionsList;
      final List<Offset> rightEyebrowBottom =
          faces[i]
              .getContour(FaceContourType.rightEyebrowBottom)
              .positionsList;
      final List<Offset> rightEyebrowTop =
          faces[i]
              .getContour(FaceContourType.rightEyebrowTop)
              .positionsList;
      final List<Offset> leftEye =
          faces[i]
              .getContour(FaceContourType.leftEye)
              .positionsList;
      final List<Offset> rightEye =
          faces[i]
              .getContour(FaceContourType.rightEye)
              .positionsList;
      final List<Offset> noseBridge =
          faces[i]
              .getContour(FaceContourType.noseBridge)
              .positionsList;

      final lipPaint = Paint()
        ..strokeWidth = 3.0
        ..color = Colors.pink;

      canvas.drawPoints(
          ui.PointMode.polygon,
          _scalePoints(
              offsets: leftEyebrowBottom,
              imageSize:absoluteImageSize,
              widgetSize: size),
          Paint()
            ..strokeWidth = 3.0
            ..color = Colors.brown);

      canvas.drawPoints(
          ui.PointMode.polygon,
          _scalePoints(
              offsets: leftEyebrowTop, imageSize:absoluteImageSize, widgetSize: size),
          Paint()
            ..strokeWidth = 3.0
            ..color = Colors.brown);

      canvas.drawPoints(
          ui.PointMode.polygon,
          _scalePoints(
              offsets: rightEyebrowBottom,
              imageSize:absoluteImageSize,
              widgetSize: size),
          Paint()
            ..strokeWidth = 3.0
            ..color = Colors.brown);

      canvas.drawPoints(
          ui.PointMode.polygon,
          _scalePoints(
              offsets: rightEyebrowTop, imageSize: absoluteImageSize, widgetSize: size),
          Paint()
            ..strokeWidth = 3.0
            ..color = Colors.brown);

      canvas.drawPoints(
          ui.PointMode.polygon,
          _scalePoints(
              offsets: leftEye, imageSize: absoluteImageSize, widgetSize: size),
          Paint()
            ..strokeWidth = 3.0
            ..color = Colors.blue);

      canvas.drawPoints(
          ui.PointMode.polygon,
          _scalePoints(
              offsets: rightEye, imageSize: absoluteImageSize, widgetSize: size),
          Paint()
            ..strokeWidth = 3.0
            ..color = Colors.blue);

      canvas.drawPoints(
          ui.PointMode.polygon,
          _scalePoints(
              offsets: noseBridge, imageSize: absoluteImageSize, widgetSize: size),
          Paint()
            ..strokeWidth = 3.0
            ..color = Colors.greenAccent);

      canvas.drawPoints(
          ui.PointMode.polygon,
          _scalePoints(
              offsets: facePoints, imageSize: absoluteImageSize, widgetSize: size),
          Paint()
            ..strokeWidth = 3.0
            ..color = Colors.white);

    }


    //  face.getLandmark(FaceLandmarkType.leftEye).position.distance * scaleX,

    final ui.ParagraphBuilder builder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontSize: 23.0,
          textDirection: TextDirection.ltr),
    );

    builder.pushStyle(ui.TextStyle(color: Colors.green));

    for (Face face in faces) {
      //0 eyes are closed 1 eyes are open
      if (face.rightEyeOpenProbability != null) {
        builder.addText('Label: '
            'rightEyeOpenProbability: ${face.rightEyeOpenProbability
            .toStringAsFixed(2)}\n');
      }
      if (face.leftEyeOpenProbability != null) {
        builder.addText('Label: '
            'rightEyeOpenProbability: ${face.leftEyeOpenProbability
            .toStringAsFixed(2)}\n');
      }

      canvas.drawRect(
        Rect.fromLTRB(
          face
              .getLandmark(FaceLandmarkType.leftEar)
              .position
              .dx * scaleX,
          face
              .getContour(FaceContourType.leftEyebrowTop)
              .positionsList[0].dy * scaleY,
          face
              .getLandmark(FaceLandmarkType.rightEar)
              .position
              .dx * scaleX,
          face
              .getLandmark(FaceLandmarkType.noseBase)
              .position
              .dy * scaleY,
        ),
        paint,
      );

      builder.pop();
      canvas.drawParagraph(
        builder.build()
          ..layout(ui.ParagraphConstraints(
            width: size.width,
          )),
        const Offset(0.0, 0.0),
      );
      rect = Rect.fromLTRB(
        face
            .getLandmark(FaceLandmarkType.leftEar)
            .position
            .dx * scaleX,
        face
            .getContour(FaceContourType.leftEyebrowTop)
            .positionsList[0].dy * scaleY,
        face
            .getLandmark(FaceLandmarkType.rightEar)
            .position
            .dx * scaleX,
        face
            .getLandmark(FaceLandmarkType.noseBase)
            .position
            .dy * scaleY,
      );

      Rect getClip() {
        Rect rect = Rect.fromLTRB(
          face
              .getLandmark(FaceLandmarkType.leftEar)
              .position
              .dx * scaleX,
          face
              .getContour(FaceContourType.leftEyebrowTop)
              .positionsList[0].dy * scaleY,
          face
              .getLandmark(FaceLandmarkType.rightEar)
              .position
              .dx * scaleX,
          face
              .getLandmark(FaceLandmarkType.noseBase)
              .position
              .dy * scaleY,
        );
        return rect;
      }

    }

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
          .map((offset) => Offset(
          widgetSize.width - (offset.dx * scaleX), offset.dy * scaleY))
          .toList();
    }
    return offsets
        .map((offset) => Offset(offset.dx * scaleX, offset.dy * scaleY))
        .toList();
  }


  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.faces != faces;
  }
}

class LabelDetectorPainter extends CustomPainter {
  LabelDetectorPainter(this.absoluteImageSize, this.labels);

  final Size absoluteImageSize;
  final List<ImageLabel> labels;

  @override
  void paint(Canvas canvas, Size size) {
    final ui.ParagraphBuilder builder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontSize: 23.0,
          textDirection: TextDirection.ltr),
    );

    builder.pushStyle(ui.TextStyle(color: Colors.green));
    for (ImageLabel label in labels) {
      builder.addText('Label: ${label.text}, '
          'Confidence: ${label.confidence.toStringAsFixed(2)}\n');
    }
    builder.pop();

    canvas.drawParagraph(
      builder.build()
        ..layout(ui.ParagraphConstraints(
          width: size.width,
        )),
      const Offset(0.0, 0.0),
    );
  }

  @override
  bool shouldRepaint(LabelDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.labels != labels;
  }
}

// Paints rectangles around all the text in the image.
class TextDetectorPainter extends CustomPainter {
  TextDetectorPainter(this.absoluteImageSize, this.visionText);

  final Size absoluteImageSize;
  final VisionText visionText;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    Rect scaleRect(TextContainer container) {
      return Rect.fromLTRB(
        container.boundingBox.left * scaleX,
        container.boundingBox.top * scaleY,
        container.boundingBox.right * scaleX,
        container.boundingBox.bottom * scaleY,
      );
    }

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          paint.color = Colors.green;
          canvas.drawRect(scaleRect(element), paint);
        }

        paint.color = Colors.yellow;
        canvas.drawRect(scaleRect(line), paint);
      }

      paint.color = Colors.red;
      canvas.drawRect(scaleRect(block), paint);
    }
  }

  @override
  bool shouldRepaint(TextDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.visionText != visionText;
  }
}

class TriangleClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.addRect(rect);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper2 oldClipper) => false;
}


// Paints rectangles around all the text in the document image.
class DocumentTextDetectorPainter extends CustomPainter {
  DocumentTextDetectorPainter(this.absoluteImageSize, this.visionDocumentText);

  final Size absoluteImageSize;
  final VisionDocumentText visionDocumentText;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    Rect scaleRect(DocumentTextContainer container) {
      return Rect.fromLTRB(
        container.boundingBox.left * scaleX,
        container.boundingBox.top * scaleY,
        container.boundingBox.right * scaleX,
        container.boundingBox.bottom * scaleY,
      );
    }

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (DocumentTextBlock block in visionDocumentText.blocks) {
      for (DocumentTextParagraph paragraph in block.paragraphs) {
        for (DocumentTextWord word in paragraph.words) {
          for (DocumentTextSymbol symbol in word.symbols) {
            paint.color = Colors.green;
            canvas.drawRect(scaleRect(symbol), paint);
          }
          paint.color = Colors.yellow;
          canvas.drawRect(scaleRect(word), paint);
        }
        paint.color = Colors.red;
        canvas.drawRect(scaleRect(paragraph), paint);
      }
      paint.color = Colors.blue;
      canvas.drawRect(scaleRect(block), paint);
    }
  }

  @override
  bool shouldRepaint(DocumentTextDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.visionDocumentText != visionDocumentText;
  }
}