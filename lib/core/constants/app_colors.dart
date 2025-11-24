import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF4A90E2);
  static const Color primaryBlueLight = Color(0xFF5B9FEE);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Card Colors
  static const Color cardTeal = Color(0xFF009688);
  static const Color cardOrange = Color(0xFFFF9800);
  static const Color cardRed = Color(0xFFF44336);
  static const Color cardPurple = Color(0xFF9C27B0);
  static const Color cardGreen = Color(0xFF4CAF50);
  static const Color cardIndigo = Color(0xFF3F51B5);

  // Neutral Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color divider = Color(0xFFE0E0E0);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryBlueLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
