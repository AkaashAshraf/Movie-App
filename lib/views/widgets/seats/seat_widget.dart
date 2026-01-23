import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

enum SeatType { selected, unavailable, vip, regular }

class SeatWidget extends StatelessWidget {
  final SeatType type;

  const SeatWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final color = switch (type) {
      SeatType.selected => AppColors.mustard,
      SeatType.unavailable => AppColors.lightGrey,
      SeatType.vip => AppColors.purple,
      SeatType.regular => AppColors.skyBlue,
    };

    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
