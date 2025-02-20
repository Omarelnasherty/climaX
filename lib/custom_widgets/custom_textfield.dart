import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
              ),
            ),
            child: TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                border: InputBorder.none,
                hintText: 'E.g., Cairo, Dubai...',
                hintStyle: GoogleFonts.poppins(
                  color: Colors.white60,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
