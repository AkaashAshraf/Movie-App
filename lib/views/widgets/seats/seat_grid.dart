import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/helper.dart';
import '../../../../core/constants/app_colors.dart';
import 'seat_widget.dart';

class SeatGrid extends StatelessWidget {
  const SeatGrid({super.key});

  static const double seatSize = 11;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(SeatLayoutHelper.rows, (rowIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Text(
                    '${rowIndex + 1}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      SeatLayoutHelper.cols,
                      (colIndex) {
                        if (!SeatLayoutHelper.shouldRenderSeat(
                            rowIndex, colIndex)) {
                          return const SizedBox(width: seatSize);
                        }

                        return SeatWidget(
                          type: mockSeatType(rowIndex, colIndex),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
