import 'package:equations_solver/routes/utils/plot_widget/plot_mode.dart';
import 'package:flutter/material.dart';

/// A [CustomPainter] that creates a XY cartesian plane and draws any kind of
/// mathematical function on it. Thanks to its [range] parameter, the user is
/// able to define the "scale" of the plot (or the "zoom").
class PlotterPainter<T> extends CustomPainter {
  final int _xmax;
  final int _xmin;
  final int _ymax;
  final int _ymin;

  /// Provides the ability to evaluate a real function on a point.
  ///
  /// If this is `null` then the painter only draws a cartesian plane (without
  /// a function).
  final PlotMode<T>? plotMode;

  /// The 'scale' of the plot
  final int range;

  /// Draws a cartesian plane with a grey grid lines and black (thick) X and Y
  /// axis. The function instead is plotted in [Colors.blueAccent].
  const PlotterPainter({
    required this.plotMode,
    this.range = 5,
  })  : _xmax = range,
        _ymax = range,
        _xmin = -range,
        _ymin = -range;

  @override
  void paint(Canvas canvas, Size size) {
    _drawMainAxis(canvas, size);
    _drawAxis(canvas, size);

    // Drawing the function ONLY if there's an evaluator available
    if (plotMode != null) {
      _drawEquation(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant PlotterPainter<T> oldDelegate) {
    return (range != oldDelegate.range) || (plotMode != oldDelegate.plotMode);
  }

  void _drawMainAxis(Canvas canvas, Size size) {
    final blackThick = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    canvas
      ..drawLine(Offset(0, size.height / 2),
          Offset(size.width, size.height / 2), blackThick)
      ..drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height),
          blackThick);
  }

  void _drawAxis(Canvas canvas, Size size) {
    final line = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 1.0;

    // Drawing X and Y axis
    final scale = range;
    final distX = (size.width / 2) / scale;
    final distY = (size.height / 2) / scale;

    var prevPoint = Offset(distX, 0);
    var currPoint = Offset(0, distY);

    // Drawing the grid (with scaling)
    for (var i = -scale; i < scale; ++i) {
      if (i == 0) {
        continue;
      }

      canvas
        ..drawLine(prevPoint, Offset(prevPoint.dx, size.height), line)
        ..drawLine(currPoint, Offset(size.width, currPoint.dy), line);

      prevPoint = Offset(prevPoint.dx + distX, prevPoint.dy);
      currPoint = Offset(currPoint.dx, currPoint.dy + distY);
    }
  }

  void _drawEquation(Canvas canvas, Size size) {
    final line = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 2.0;

    var logy = 0.0;
    var logx = 0.0;

    final width = size.width;
    final height = size.height;

    var currPoint = Offset.zero;
    var prevPoint = Offset.zero;

    for (var i = 0; i < size.width; ++i) {
      logx = _screenToLog(Offset(i * 1.0, 0), width, height).dx;

      // Using '!' on 'plotMode' here is safe because this function is called
      // only if 'plotMode != null' (see the 'paint' method above)
      logy = plotMode!.evaluateOn(logx);

      final pts = Offset(logx, logy);
      currPoint = Offset(i * 1.0, _logToScreen(pts, width, height).dy);

      if (currPoint.dx > 0) {
        canvas.drawLine(currPoint, prevPoint, line);
      }

      prevPoint = currPoint;
    }
  }

  Offset _screenToLog(Offset screenPoint, double width, double height) {
    return Offset(
      _xmin + (screenPoint.dx / width) * (_xmax - _xmin),
      _ymin + (height - screenPoint.dy) * (_ymax - _ymin),
    );
  }

  Offset _logToScreen(Offset logPoint, double width, double height) {
    return Offset(
      width * (logPoint.dx - _xmin) / (_xmax - _xmin),
      height - height * (logPoint.dy - _ymin) / (_ymax - _ymin),
    );
  }
}
