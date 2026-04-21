import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6366F1);    // Indigo Accent
  static const Color background = Color(0xFFF8FAFC); // Soft Porcelain
  static const Color surface = Color(0xFFFFFFFF);    // Pure White
  static const Color textPrimary = Color(0xFF1E293B);   // Slate Dark
  static const Color textSecondary = Color(0xFF64748B); // Slate Grey

  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}