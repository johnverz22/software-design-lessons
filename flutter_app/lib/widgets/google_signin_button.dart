import 'package:flutter/material.dart';
import 'dart:math' as math;

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const GoogleSignInButton({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google logo
                  Container(
                    height: 24,
                    width: 24,
                    child: const CustomPaint(
                      painter: GoogleLogoPainter(),
                      size: Size(24, 24),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class GoogleLogoPainter extends CustomPainter {
  const GoogleLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    
    // Define Google logo colors
    const Color red = Color(0xFFEA4335);
    const Color green = Color(0xFF34A853);
    const Color yellow = Color(0xFFFBBC05);
    const Color blue = Color(0xFF4285F4);

    final Paint paint = Paint()
      ..style = PaintingStyle.fill;
    
    // Draw blue arc
    paint.color = blue;
    var path = Path()
      ..moveTo(width * 0.75, height * 0.5)
      ..arcTo(
        Rect.fromLTRB(width * 0.25, height * 0.25, width * 0.75, height * 0.75),
        -math.pi / 2,
        math.pi,
        false,
      )
      ..lineTo(width * 0.75, height * 0.5)
      ..close();
    canvas.drawPath(path, paint);
    
    // Draw yellow triangle
    paint.color = yellow;
    path = Path()
      ..moveTo(width * 0.25, height * 0.5)
      ..lineTo(width * 0.5, height * 0.25)
      ..lineTo(width * 0.5, height * 0.5)
      ..close();
    canvas.drawPath(path, paint);
    
    // Draw green triangle
    paint.color = green;
    path = Path()
      ..moveTo(width * 0.5, height * 0.75)
      ..lineTo(width * 0.5, height * 0.5)
      ..lineTo(width * 0.25, height * 0.5)
      ..close();
    canvas.drawPath(path, paint);
    
    // Draw red triangle
    paint.color = red;
    path = Path()
      ..moveTo(width * 0.5, height * 0.25)
      ..lineTo(width * 0.75, height * 0.5)
      ..lineTo(width * 0.5, height * 0.5)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
} 