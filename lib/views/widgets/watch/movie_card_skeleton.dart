import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class MovieCardSkeleton extends StatelessWidget {
  const MovieCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
