import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_colors.dart';
import 'package:movie_app/views/widgets/seats/mini_seat_grid.dart';

class ShowtimeCard extends StatelessWidget {
  final String time;
  final String hall;
  final String priceText;
  final bool isSelected;
  final VoidCallback onTap;

  const ShowtimeCard({
    super.key,
    required this.time,
    required this.hall,
    required this.priceText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkPurple,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    hall,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                    color:
                        isSelected ? AppColors.skyBlue : AppColors.lightGrey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const MiniSeatGrid(),
            ),
            const SizedBox(height: 12),
            Text(
              priceText,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.darkPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
