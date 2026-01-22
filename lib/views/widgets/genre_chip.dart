import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_colors.dart';

class GenreChip extends StatelessWidget {
  final String label;

  const GenreChip({
    required this.label,
  });

  Color _resolveColor() {
    switch (label.toLowerCase()) {
      case 'action':
        return AppColors.chipAction;
      case 'thriller':
        return AppColors.chipThriller;
      case 'horror':
        return AppColors.chipHorror;
      case 'mystery':
        return AppColors.chipMystry;

      case 'science fiction':
      case 'sci-fi':
        return AppColors.chipSciFi;
      case 'fantasy':
        return AppColors.chipFantasy;
      default:
        return AppColors.chipAction;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _resolveColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.pureWhite,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
