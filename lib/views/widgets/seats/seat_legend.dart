import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class SeatLegend extends StatelessWidget {
  const SeatLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 10,
        childAspectRatio: 5,
        children: const [
          _Legend(color: AppColors.mustard, label: "Selected"),
          _Legend(color: AppColors.lightGrey, label: "Not available"),
          _Legend(color: AppColors.purple, label: "VIP (150\$)"),
          _Legend(color: AppColors.skyBlue, label: "Regular (50\$)"),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;

  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
