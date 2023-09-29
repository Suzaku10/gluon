import 'package:flutter/material.dart';

class TooltipShapeBorder extends ShapeBorder {
  final double arrowWidth = 10.0;
  final double arrowHeight = 10.0;
  final double borderRadius = 8.0;
  final double padding = 8.0;
  final double arrowPosition;

  const TooltipShapeBorder({this.arrowPosition = 0.5});

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();

    // Create the rectangle for the tooltip
    path.addRRect(RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius),
    ));

    // Calculate the tooltip arrowhead position
    final arrowX = rect.left + rect.width * arrowPosition;
    final arrowY = rect.bottom;

    // Move to the arrowhead position
    path.moveTo(arrowX - arrowWidth / 2, arrowY);

    // Draw the arrowhead
    path.lineTo(arrowX, arrowY + arrowHeight);
    path.lineTo(arrowX + arrowWidth / 2, arrowY);

    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return TooltipShapeBorder(arrowPosition: arrowPosition);
  }
}