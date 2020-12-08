import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:digital_eye_app/Screens/TabBarScreens/DoctorList/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

class FacePaint extends CustomPaint {
  final CustomPainter painter;

  FacePaint({this.painter}) : super(painter: painter);
}

class FaceContourPainter extends CustomPainter {
  final Size imageSize;
  final List<Face> faces;
  final CameraLensDirection cameraLensDirection;

  FaceContourPainter(this.imageSize, this.faces, this.cameraLensDirection);

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < faces.length; i++) {
      final List<Offset> facePoints =
          faces[i].getContour(FaceContourType.face).positionsList;
      final List<Offset> leftEyebrowBottom =
          faces[i].getContour(FaceContourType.leftEyebrowBottom).positionsList;
      final List<Offset> leftEyebrowTop =
          faces[i].getContour(FaceContourType.leftEyebrowTop).positionsList;
      final List<Offset> rightEyebrowBottom =
          faces[i].getContour(FaceContourType.rightEyebrowBottom).positionsList;
      final List<Offset> rightEyebrowTop =
          faces[i].getContour(FaceContourType.rightEyebrowTop).positionsList;
      final List<Offset> leftEye =
          faces[i].getContour(FaceContourType.leftEye).positionsList;
      final List<Offset> rightEye =
          faces[i].getContour(FaceContourType.rightEye).positionsList;
      final List<Offset> noseBridge =
          faces[i].getContour(FaceContourType.noseBridge).positionsList;

      final lipPaint = Paint()
        ..strokeWidth = 3.0
        ..color = Colors.pink;


      canvas.drawPoints(
          PointMode.polygon,
          _scalePoints(
              offsets: leftEyebrowBottom,
              imageSize: imageSize,
              widgetSize: size),
          Paint()
            ..strokeWidth = 3.0
            ..color = Colors.brown);

      canvas.drawPoints(
          PointMode.polygon,
          _scalePoints(
              offsets: leftEyebrowTop, imageSize: imageSize, widgetSize: size),
          Paint()
            ..strokeWidth = 3.0
            ..color = Colors.brown);

      canvas.drawPoints(
          PointMode.polygon,
          _scalePoints(
              offsets: rightEyebrowBottom,
              imageSize: imageSize,
              widgetSize: size),
          Paint()
            ..strokeWidth = 3.0
            ..color = Colors.brown);

      canvas.drawPoints(
          PointMode.polygon,
          _scalePoints(
              offsets: rightEyebrowTop, imageSize: imageSize, widgetSize: size),
          Paint()
            ..strokeWidth = 3.0
            ..color = Colors.brown);

      canvas.drawPoints(
          PointMode.polygon,
          _scalePoints(
              offsets: leftEye, imageSize: imageSize, widgetSize: size),
          Paint()
            ..strokeWidth = 3.0
            ..color = Colors.blue);

      canvas.drawPoints(
          PointMode.polygon,
          _scalePoints(
              offsets: rightEye, imageSize: imageSize, widgetSize: size),
          Paint()
            ..strokeWidth = 3.0
            ..color = Colors.blue);


      canvas.drawPoints(
          PointMode.polygon,
          _scalePoints(
              offsets: noseBridge, imageSize: imageSize, widgetSize: size),
          Paint()
            ..strokeWidth = 3.0
            ..color = Colors.greenAccent);

      canvas.drawPoints(
          PointMode.polygon,
          _scalePoints(
              offsets: facePoints, imageSize: imageSize, widgetSize: size),
          Paint()
            ..strokeWidth = 3.0
            ..color = Colors.white);
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
  bool shouldRepaint(FaceContourPainter oldDelegate) {
    return imageSize != oldDelegate.imageSize || faces != oldDelegate.faces;
  }
}