// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:digital_eye_app/Screens/TabBarScreens/DoctorList/firebase_ml_vision.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_crop/image_crop.dart';

import 'detector_painters.dart';
import 'imageprocessing.dart';
import 'dart:ui' as ui;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core ;
import 'package:path_provider/path_provider.dart';



class PictureScanner extends StatefulWidget {

  final barcodePictureFilePath;
  PictureScanner({this.barcodePictureFilePath});


  @override
  State<StatefulWidget> createState() => _PictureScannerState();
}

class _PictureScannerState extends State<PictureScanner> {
  File _imageFile;
  Size _imageSize;
  dynamic _scanResults;
  Detector _currentDetector = Detector.face;
  final BarcodeDetector _barcodeDetector =
  FirebaseVision.instance.barcodeDetector();
  final FaceDetector _faceDetector = FirebaseVision.instance.faceDetector();
  final ImageLabeler _imageLabeler = FirebaseVision.instance.imageLabeler();
  final ImageLabeler _cloudImageLabeler =
  FirebaseVision.instance.cloudImageLabeler();
  final TextRecognizer _recognizer = FirebaseVision.instance.textRecognizer();
  final TextRecognizer _cloudRecognizer =
  FirebaseVision.instance.cloudTextRecognizer();
  final DocumentTextRecognizer _cloudDocumentRecognizer =
  FirebaseVision.instance.cloudDocumentTextRecognizer();
  final ImagePicker _picker = ImagePicker();

  Future<void> _getAndScanImage() async {
    setState(() {
      _imageFile = null;
      _imageSize = null;
    });

    final PickedFile pickedImage =
    await _picker.getImage(source: ImageSource.gallery);
    final File imageFile = File(pickedImage.path);

    if (imageFile != null) {
      _getImageSize(imageFile);
      _scanImage(imageFile);
    }

    setState(() {
      _imageFile = imageFile;
    });
  }

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();

    final Image image = Image.file(imageFile);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;
    setState(() {
      _imageSize = imageSize;
    });
  }

  Future<void> _scanImage(File imageFile) async {
    setState(() {
      _scanResults = null;
    });

    final FirebaseVisionImage visionImage =
    FirebaseVisionImage.fromFile(imageFile);

    dynamic results;
    switch (_currentDetector) {
      case Detector.barcode:
        results = await _barcodeDetector.detectInImage(visionImage);
        break;
      case Detector.face:
        results = await _faceDetector.processImage(visionImage);
        break;
      case Detector.label:
        results = await _imageLabeler.processImage(visionImage);
        break;
      case Detector.cloudLabel:
        results = await _cloudImageLabeler.processImage(visionImage);
        break;
      case Detector.text:
        results = await _recognizer.processImage(visionImage);
        break;
      case Detector.cloudText:
        results = await _cloudRecognizer.processImage(visionImage);
        break;
      case Detector.cloudDocumentText:
        results = await _cloudDocumentRecognizer.processImage(visionImage);
        break;
      default:
        return;
    }

    setState(() {
      _scanResults = results;
    });
  }

  CustomPaint _buildResults(Size imageSize, dynamic results) {
    CustomPainter painter;

    switch (_currentDetector) {
      case Detector.barcode:
        painter = BarcodeDetectorPainter(_imageSize, results);
        break;
      case Detector.face:
        painter = FaceDetectorPainter(_imageSize, results);
        break;
      case Detector.label:
        painter = LabelDetectorPainter(_imageSize, results);
        break;
      case Detector.cloudLabel:
        painter = LabelDetectorPainter(_imageSize, results);
        break;
      case Detector.text:
        painter = TextDetectorPainter(_imageSize, results);
        break;
      case Detector.cloudText:
        painter = TextDetectorPainter(_imageSize, results);
        break;
      case Detector.cloudDocumentText:
        painter = DocumentTextDetectorPainter(_imageSize, results);
        break;
      default:
        break;
    }

    return CustomPaint(
      painter: painter,
    );
  }

  Widget _buildImage() {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.file(_imageFile).image,
          fit: BoxFit.fill,
        ),
      ),
      child: _imageSize == null || _scanResults == null
          ? const Center(
        child: Text(
          'Scanning...',
          style: TextStyle(
            color: Colors.green,
            fontSize: 30.0,
          ),
        ),
      )
          : _buildResults(_imageSize, _scanResults),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picture Scanner'),
        actions: <Widget>[
          PopupMenuButton<Detector>(
            onSelected: (Detector result) {
              _currentDetector = result;
              if (_imageFile != null) _scanImage(_imageFile);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Detector>>[
              const PopupMenuItem<Detector>(
                child: Text('Detect Barcode'),
                value: Detector.barcode,
              ),
              const PopupMenuItem<Detector>(
                child: Text('Detect Face'),
                value: Detector.face,
              ),
              const PopupMenuItem<Detector>(
                child: Text('Detect Label'),
                value: Detector.label,
              ),
              const PopupMenuItem<Detector>(
                child: Text('Detect Cloud Label'),
                value: Detector.cloudLabel,
              ),
              const PopupMenuItem<Detector>(
                child: Text('Detect Text'),
                value: Detector.text,
              ),
              const PopupMenuItem<Detector>(
                child: Text('Detect Cloud Text'),
                value: Detector.cloudText,
              ),
              const PopupMenuItem<Detector>(
                child: Text('Detect Document Text'),
                value: Detector.cloudDocumentText,
              ),
            ],
          ),
        ],
      ),
      body: _imageFile == null
          ? const Center(child: Text('No image selected.'))
          : _buildImage(),
      floatingActionButton: FloatingActionButton(
        onPressed: _getAndScanImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  @override
  void dispose() {
    _barcodeDetector.close();
    _faceDetector.close();
    _imageLabeler.close();
    _cloudImageLabeler.close();
    _recognizer.close();
    _cloudRecognizer.close();
    super.dispose();
  }
}