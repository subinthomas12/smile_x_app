import 'dart:math';

import 'package:flutter/material.dart';

class CircularProgressWithPointer extends StatelessWidget {
  final double radius;
  final double progress; // Progress value (between 0.0 and 1.0)
  final Color progressColor;
  final Color? pointerAvatarColor;
  final IconData iconData;
  final double? iconSize;
  final double? strokeWidth;
  final double? pointerAvatarRadius;
  final Color? nonProgressColor;
  final Color? pointerIconColor;
  const CircularProgressWithPointer({
    super.key,
    this.radius = 0.2,
    this.progress = 0.6,
    required this.progressColor,
    this.pointerAvatarColor,
    required this.iconData,
    this.iconSize,
    this.strokeWidth,
    this.pointerAvatarRadius,
    this.nonProgressColor,
    this.pointerIconColor,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: CustomPaint(
        size: Size(screenWidth * radius, screenWidth * radius),
        painter: ProgressWithPointerPainter(
          progress: progress,
          progressColor: progressColor,
          pointerAvatarColor: pointerAvatarColor,
          iconData: iconData,
          iconSize: iconSize,
          strokeWidth: strokeWidth,
          pointerAvatarRadius: pointerAvatarRadius,
          nonProgressColor: nonProgressColor,
          pointerIconColor: pointerIconColor,
        ),
      ),
    );
  }
}

class ProgressWithPointerPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color? pointerAvatarColor;
  final IconData iconData;
  final double? iconSize;
  final double? strokeWidth;
  final double? pointerAvatarRadius;
  final Color? nonProgressColor;
  final Color? pointerIconColor;

// Constructor: Assign constructor parameters to class properties
  ProgressWithPointerPainter({
    required this.progress,
    required this.progressColor,
    this.pointerAvatarColor,
    required this.iconData,
    this.iconSize,
    this.strokeWidth,
    this.pointerAvatarRadius,
    this.nonProgressColor,
    this.pointerIconColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()
      ..color = nonProgressColor ?? Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth ?? 16;

    Paint progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth ?? 16
      ..strokeCap = StrokeCap.round;

    // Paint pointerPaint = Paint()
    //   ..color = Colors.black
    //   ..style = PaintingStyle.fill;

    // Draw background circle
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, circlePaint);

    // Draw progress arc (the actual progress)
    double angle = 2 * pi * progress; // Angle for the progress arc
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2),
      -pi / 2, // Start angle (top of the circle)
      angle, // Sweep angle (calculated based on progress)
      false,
      progressPaint,
    );

    // Draw pointer (needle) at the end of the progress arc
    double pointerAngle =
        -pi / 2 + angle; // Calculate pointer's angle based on progress
    double pointerLength = size.width / 2; // Length of the pointer

    // Calculate the pointer's position
    double x = size.width / 2 + pointerLength * cos(pointerAngle);
    double y = size.height / 2 + pointerLength * sin(pointerAngle);

    // Draw the pointer (needle)
    // canvas.drawLine(
    //   Offset(size.width / 2, size.height / 2), // Start from the center
    //   Offset(x, y), // End at the calculated position
    //   pointerPaint,
    // );

    // Now, draw the CircleAvatar with the Icon at the end of the pointer
    double avatarRadius =
        pointerAvatarRadius ?? 18.0; // Radius of the CircleAvatar
    // double avatarOffsetX =
    //     x - avatarRadius; // Offset for the CircleAvatar's X position
    // double avatarOffsetY =
    //     y - avatarRadius; // Offset for the CircleAvatar's Y position

    // Create a circle manually to represent the CircleAvatar
    Paint avatarPaint = Paint()
      ..color = pointerAvatarColor ?? Colors.white
      ..style = PaintingStyle.fill;

    // Draw the circle for the avatar
    canvas.drawCircle(
      Offset(x, y),
      avatarRadius,
      avatarPaint,
    );

    // Now draw the icon inside the CircleAvatar (we use a text painter to simulate an icon)
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(iconData.codePoint),
        style: TextStyle(
          fontFamily:
              iconData.fontFamily, // Ensure it uses the correct font family
          fontSize: iconSize ?? 20, // Set the icon size
          color: pointerIconColor ?? Colors.black, // Icon color
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(x - textPainter.width / 2,
          y - textPainter.height / 2), // Center the icon in the avatar
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
