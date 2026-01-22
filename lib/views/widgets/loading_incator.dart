import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.darkPurple,
        ),
      ),
    );
  }
}
