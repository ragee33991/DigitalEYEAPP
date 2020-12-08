import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/painting.dart' as painting;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


/// Strategy used when filling the area of a sparkline.
enum FillMode {
  /// Do not fill, draw only the sparkline.
  none,

  /// Fill the area above the sparkline: creating a closed path from the line
  /// to the upper edge of the widget.
  above,

  /// Fill the area below the sparkline: creating a closed path from the line
  /// to the lower edge of the widget.
  below,
}

/// Strategy used when drawing individual data points over the sparkline.
enum PointsMode {
  /// Do not draw individual points.
  none,

  /// Draw all the points in the data set.
  all,

  /// Draw only the last point in the data set.
  last,
}

/// A widget that draws a sparkline chart.
///
/// Represents the given [data] in a sparkline chart that spans the available
/// space.
///
/// By default only the sparkline is drawn, with its looks defined by
/// the [lineWidth], [lineColor], and [lineGradient] properties.
///
/// The corners between two segments of the sparkline can be made sharper by
/// setting [sharpCorners] to true.
///
/// The area above or below the sparkline can be filled with the provided
/// [fillColor] or [fillGradient] by setting the desired [fillMode].
///
/// [pointsMode] controls how individual points are drawn over the sparkline
/// at the provided data point. Their appearance is determined by the
/// [pointSize] and [pointColor] properties.
///
/// By default, the sparkline is sized to fit its container. If the
/// sparkline is in an unbounded space, it will size itself according to the
/// given [fallbackWidth] and [fallbackHeight].
class Sparkline extends StatelessWidget {
  /// Creates a widget that represents provided [data] in a Sparkline chart.
  Sparkline({
    Key key,
    @required this.data,
    this.lineWidth = 2.0,
    this.unitHeight = 50,
    this.lineColor = Colors.lightBlue,
    this.lineGradient,
    this.showValue = false,
    this.pointsMode = PointsMode.none,
    this.pointSize = 4.0,
    this.pointColor = const Color(0xFF0277BD), //Colors.lightBlue[800]
    this.sharpCorners = false,
    this.fillMode = FillMode.none,
    this.fillColor = const Color(0xFF81D4FA), //Colors.lightBlue[200]
    this.fillGradient,
    this.fallbackHeight = 100.0,
    this.fallbackWidth = 300.0,
  })  : assert(data != null),
        assert(lineWidth != null),
        assert(lineColor != null),
        assert(pointsMode != null),
        assert(pointSize != null),
        assert(pointColor != null),
        assert(sharpCorners != null),
        assert(fillMode != null),
        assert(fillColor != null),
        assert(fallbackHeight != null),
        assert(fallbackWidth != null),
        super(key: key);

  /// List of values to be represented by the sparkline.
  ///
  /// Each data entry represents an individual point on the chart, with a path
  /// drawn connecting the consecutive points to form the sparkline.
  ///
  /// The values are normalized to fit within the bounds of the chart.
  final List<double> data;

  /// The width of the sparkline.
  ///
  /// Defaults to 2.0.
  final double lineWidth;

  final double unitHeight;

  /// The color of the sparkline.
  ///
  /// Defaults to Colors.lightBlue.
  ///
  /// This is ignored if [lineGradient] is non-null.
  final Color lineColor;

  final bool showValue;

  /// A gradient to use when coloring the sparkline.
  ///
  /// If this is specified, [lineColor] has no effect.
  final Gradient lineGradient;

  /// Determines how individual data points should be drawn over the sparkline.
  ///
  /// Defaults to [PointsMode.none].
  final PointsMode pointsMode;

  /// The size to use when drawing individual data points over the sparkline.
  ///
  /// Defaults to 4.0.
  final double pointSize;

  /// The color used when drawing individual data points over the sparkline.
  ///
  /// Defaults to Colors.lightBlue[800].
  final Color pointColor;

  /// Determines if the sparkline path should have sharp corners where two
  /// segments intersect.
  ///
  /// Defaults to false.
  final bool sharpCorners;

  /// Determines the area that should be filled with [fillColor].
  ///
  /// Defaults to [FillMode.none].
  final FillMode fillMode;

  /// The fill color used in the chart, as determined by [fillMode].
  ///
  /// Defaults to Colors.lightBlue[200].
  ///
  /// This is ignored if [fillGradient] is non-null.
  final Color fillColor;

  /// A gradient to use when filling the chart, as determined by [fillMode].
  ///
  /// If this is specified, [fillColor] has no effect.
  final Gradient fillGradient;

  /// The width to use when the sparkline is in a situation with an unbounded
  /// width.
  ///
  /// See also:
  ///
  ///  * [fallbackHeight], the same but vertically.
  final double fallbackWidth;

  /// The height to use when the sparkline is in a situation with an unbounded
  /// height.
  ///
  /// See also:
  ///
  ///  * [fallbackWidth], the same but horizontally.
  final double fallbackHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: fallbackHeight,
      child: CustomPaint(
        size: Size.infinite,
        painter: _SparklinePainter(
          data,
          unitHeight: unitHeight,
          lineWidth: lineWidth,
          showValue: showValue,
          lineColor: lineColor,
          lineGradient: lineGradient,
          sharpCorners: sharpCorners,
          fillMode: fillMode,
          fillColor: fillColor,
          fillGradient: fillGradient,
          pointsMode: pointsMode,
          pointSize: pointSize,
          pointColor: pointColor,
        ),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter(
    this.dataPoints, {
    @required this.lineWidth,
    @required this.lineColor,
    this.unitHeight = 50,
    this.lineGradient,
    this.showValue  = false,
    @required this.sharpCorners,
    @required this.fillMode,
    @required this.fillColor,
    this.fillGradient,
    @required this.pointsMode,
    @required this.pointSize,
    @required this.pointColor,
  })  : _max = dataPoints.reduce(math.max),
        _min = dataPoints.reduce(math.min);

  final List<double> dataPoints;

  final double lineWidth;
  final Color lineColor;
  final Gradient lineGradient;

  final bool sharpCorners;

  final FillMode fillMode;
  final Color fillColor;
  final Gradient fillGradient;

  final PointsMode pointsMode;
  final double pointSize;
  final Color pointColor;

  final bool showValue;
  final double unitHeight;
  final double _max;
  final double _min;

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width - lineWidth;
    final double height = size.height - lineWidth;
    final double widthNormalizer = width / (dataPoints.length - 1);
    //final double heightNormalizer = height / (_max - _min);

    final Path path = Path();
    final List<Offset> points = <Offset>[];

    Offset startPoint;
    Offset lastPoint;

    for (int i = 0; i < dataPoints.length; i++) {
      double x = i * widthNormalizer + lineWidth / 2;
      //double y = height - (dataPoints[i] - _min) * heightNormalizer + lineWidth / 2;
      double y = height / 2 - dataPoints[i] * unitHeight;

      if (pointsMode == PointsMode.all) {
        points.add(Offset(x, y));
      }

      if (pointsMode == PointsMode.last && i == dataPoints.length - 1) {
        points.add(Offset(x, y));
      }

      if (i == 0) {
        startPoint = Offset(x, y);
        lastPoint = Offset(x, y);
        path.moveTo(x, y);
      } else {
        final double controlPointX = lastPoint.dx + (x - lastPoint.dx) / 2;
        path.cubicTo(controlPointX, lastPoint.dy, controlPointX, y, x, y);
        lastPoint = Offset(x, y);
      }
    }

    Paint paint = Paint()
      ..strokeWidth = lineWidth
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..strokeJoin = sharpCorners ? StrokeJoin.miter : StrokeJoin.round
      ..style = PaintingStyle.stroke;

    if (lineGradient != null) {
      final Rect lineRect = Rect.fromLTWH(0.0, 0.0, width, height);
      paint.shader = lineGradient.createShader(lineRect);
    }

    if (fillMode != FillMode.none) {
      Path fillPath = Path()..addPath(path, Offset.zero);
      if (fillMode == FillMode.below) {
        fillPath.relativeLineTo(lineWidth / 2, 0.0);
        fillPath.lineTo(size.width, size.height);
        fillPath.lineTo(0.0, size.height);
        fillPath.lineTo(startPoint.dx - lineWidth / 2, startPoint.dy);
      } else if (fillMode == FillMode.above) {
        fillPath.relativeLineTo(lineWidth / 2, 0.0);
        fillPath.lineTo(size.width, 0.0);
        fillPath.lineTo(0.0, 0.0);
        fillPath.lineTo(startPoint.dx - lineWidth / 2, startPoint.dy);
      }
      fillPath.close();

      Paint fillPaint = Paint()
        ..strokeWidth = 0.0
        ..color = fillColor
        ..style = PaintingStyle.fill;

      if (fillGradient != null) {
        final Rect fillRect = Rect.fromLTWH(0.0, 0.0, width, height);
        fillPaint.shader = fillGradient.createShader(fillRect);
      }
      canvas.drawPath(fillPath, fillPaint);
    }

    canvas.drawPath(path, paint);

    if (points.isNotEmpty) {
      final pointsDraw = [points[points.length - 2]];

      Paint pointsPaintBorder = Paint()
        ..strokeCap = StrokeCap.round
        ..strokeWidth = pointSize
        ..color = Color(0xFFFFFFFF);
      canvas.drawPoints(ui.PointMode.points, pointsDraw, pointsPaintBorder);

      Paint pointsPaint = Paint()
        ..strokeCap = StrokeCap.round
        ..strokeWidth = pointSize - 2
        //..shader = BlueGradient().createShader(Rect.fromCircle(center: Offset.zero, radius: pointSize / 4));
        ..color = pointColor;
      canvas.drawPoints(ui.PointMode.points, pointsDraw, pointsPaint);

      if (showValue) {
        TextSpan span = TextSpan(
            style: TextStyle(color: Color(0xFF4B66EA), fontSize: 12),
            text: '89bpm');
        TextPainter tp =
            TextPainter(text: span, textDirection: TextDirection.ltr);
        tp.layout();

        Offset offsetText = Offset(pointsDraw.last.dx - tp.width / 2,
            pointsDraw.last.dy - tp.height - 8);

        tp.paint(canvas, offsetText);
      }
    }
  }

  Offset getEndPoint(
      {double widthNormalizer, double heightNormalizer, double height}) {
    final i = dataPoints.length - 1;
    final value = dataPoints[i];
    double x = i * widthNormalizer + lineWidth / 2;
    double y = height - (value - _min) * heightNormalizer + lineWidth / 2;

    return Offset(x, y);
  }

  @override
  bool shouldRepaint(_SparklinePainter old) {
    return dataPoints != old.dataPoints ||
        lineWidth != old.lineWidth ||
        lineColor != old.lineColor ||
        lineGradient != old.lineGradient ||
        sharpCorners != old.sharpCorners ||
        fillMode != old.fillMode ||
        fillColor != old.fillColor ||
        fillGradient != old.fillGradient ||
        pointsMode != old.pointsMode ||
        pointSize != old.pointSize ||
        pointColor != old.pointColor;
  }
}
