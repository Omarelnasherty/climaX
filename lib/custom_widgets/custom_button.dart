import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color? borderColor;
  final Color? textColor;
  final VoidCallback onTap;
  final double width;

  const CustomButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
    this.borderColor,
    this.textColor,
    required this.onTap,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonHeight = width * 0.14;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(buttonHeight / 2),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: width * 0.005)
              : null,
          boxShadow: [
            if (color != Colors.transparent)
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 1,
              ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: textColor ?? Colors.white,
              size: width * 0.055,
            ),
            SizedBox(width: width * 0.025),
            Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: width * 0.04,
                fontWeight: FontWeight.w600,
                color: textColor ?? Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
