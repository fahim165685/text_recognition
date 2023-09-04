import 'package:flutter/material.dart';

class AnimatedScanWidget extends StatefulWidget {
  const AnimatedScanWidget({super.key});

  @override
  State<AnimatedScanWidget> createState() => _AnimatedScanWidgetState();
}

class _AnimatedScanWidgetState extends State<AnimatedScanWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,
      duration: const Duration(seconds: 2), // Adjust the duration as needed
    )..repeat(reverse: true);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ScanPainter(_controller.value),
        );
      },
    );
  }
}


class ScanPainter extends CustomPainter {
  final double animationValue;

  ScanPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 5.0;

    final scanLineY = size.height * animationValue;

    const gradient = LinearGradient(
      colors: [Colors.purple, Colors.blue], // Define your gradient colors
      stops: [0.0, 1.0], // Define your gradient stops
      begin: Alignment.topCenter, // Top-to-bottom gradient effect
      end: Alignment.bottomCenter,
    );

    paint.shader = gradient.createShader(
      Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)),
    );

    final shadowPaint = Paint()
      ..color = Colors.cyanAccent // Shadow color and opacity
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal,8 ) // Shadow blur
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0; // Adjust the shadow's width as needed

    canvas.drawLine(
      Offset(0, scanLineY),
      Offset(size.width, scanLineY),

      paint,
    );

    canvas.drawLine(
      Offset(0, scanLineY +  0), // Adjust the shadow position
      Offset(size.width, scanLineY + 0), // Adjust the shadow position
      shadowPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}