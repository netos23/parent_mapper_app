import 'dart:math';

import 'package:flutter/material.dart';
import 'package:parent_mapper_app/core/node.dart';

const Color BLACK_NORMAL = Colors.black;

class SizeUtil {
  static int _designWidth;
  static int _designHeight;

  static Size _logicSize;

  static get width {
    return _logicSize.width;
  }

  static get height {
    return _logicSize.height;
  }

  static set size(size) {
    _logicSize = size;
  }

  static get designWidth {
    return _designWidth;
  }

  static get designHeight {
    return _designHeight;
  }

  static set designWidth(width) {
    _designWidth = width;
  }

  static set designHeight(height) {
    _designHeight = height;
  }

  //@param w is the design w;
  static double getAxisX(double w) {
    return (w * width) / _designWidth;
  }

// the y direction
  static double getAxisY(double h) {
    return (h * height) / _designHeight;
  }

  // diagonal direction value with design size s.
  static double getAxisBoth(double s) {
    return s *
        sqrt((width * width + height * height) /
            (_designWidth * _designWidth + _designHeight * _designHeight));
  }
}

class OpenPainter extends CustomPainter {
  List<Node> _points;
  BuildContext context;

  void _drawLine(Canvas canvas, {Offset begin, Offset end, Size size, paint}) {
    begin = _convertLogicSize(begin, size);
    end = _convertLogicSize(end, size);

    var linePath = Path()
      ..moveTo(begin.dx, begin.dy)
      ..lineTo(end.dx, end.dy);

    canvas.drawPath(linePath, paint);
  }

  Offset _convertLogicSize(Offset off, Size size) {
    return Offset(SizeUtil.getAxisX(off.dx), SizeUtil.getAxisY(off.dy));
  }

  Offset _pointToOffset(Node point) {
    return Offset(point.x, point.y);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width > 1.0 && size.height > 1.0) {
      print(">1.9");
      SizeUtil.size = size;
    }
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = BLACK_NORMAL
      ..strokeWidth = 5
      ..isAntiAlias = true;

    for (var i = 1; i < _points.length; i++) {
      Offset begin = _pointToOffset(_points[i - 1]);
      Offset end = _pointToOffset(_points[i]);

      _drawLine(canvas, begin: begin, end: end, size: size, paint: paint);
    }

    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  OpenPainter(this._points, this.context, width, height){
    SizeUtil.designWidth = width;
    SizeUtil._designHeight = height;
  }

  List<Node> get points => _points;

  set points(value) {
    _points = value;
  }
}
