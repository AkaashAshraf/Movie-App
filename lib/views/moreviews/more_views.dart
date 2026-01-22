import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text(
          'More',
          style: TextStyle(
            color: AppColors.darkPurple,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.offWhite,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'More Screen',
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
