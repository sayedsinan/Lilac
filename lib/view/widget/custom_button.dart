import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final String? logoPath;
  final VoidCallback onPressed;
  final double width;
  final double height;
 

  const CustomButton({
    super.key,
    required this.text,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.white,
    this.logoPath,
    required this.onPressed, required this.width, required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
      
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          elevation: 2,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (logoPath != null) ...[
              Image.asset(logoPath!, height: 24, width: 24),
              const SizedBox(width: 10),
            ],
            Text(text, style: TextStyle(color: textColor, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
