import 'package:flutter/material.dart';

class AppColors {
  // Background
  static const Color background = Color(0xFF07111F);
  static const Color backgroundSecondary = Color(0xFF0B1930);

  // Brand
  static const Color primary = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF2563EB);
  static const Color secondary = Color(0xFF06B6D4);

  // Cards
  static const Color card = Color(0xFF111F33);
  static const Color cardLight = Color(0xFF172A44);

  // Text
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF94A3B8);

  // Status
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF2563EB),
      Color(0xFF06B6D4),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [
      Color(0xFF07111F),
      Color(0xFF0B1930),
      Color(0xFF07111F),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}