import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({
    super.key,
    required this.child,
  });

  Widget glowCircle({
    required double size,
    required Color color,
  }) {
    return Container(
      width: size,
      height: size,

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        color: color.withValues(
          alpha: 0.06,
        ),

        boxShadow: [
          BoxShadow(
            color: color.withValues(
              alpha: 0.12,
            ),
            blurRadius: 100,
            spreadRadius: 25,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,

      decoration: const BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),

      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -80,
            child: glowCircle(
              size: 260,
              color: AppColors.primary,
            ),
          ),

          Positioned(
            bottom: -120,
            left: -100,
            child: glowCircle(
              size: 300,
              color: AppColors.secondary,
            ),
          ),

          Positioned(
            top: 280,
            left: -80,
            child: glowCircle(
              size: 180,
              color: Colors.purple,
            ),
          ),

          child,
        ],
      ),
    );
  }
}