import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text(
          'Dashboard',
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
          'Dashboard Screen',
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
