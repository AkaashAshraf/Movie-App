import 'package:flutter/material.dart';
import '../../../../core/utils/helper.dart';

class MiniSeatGrid extends StatelessWidget {
  const MiniSeatGrid({super.key});

  static const double seatSize = 6;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(SeatLayoutHelper.rows, (rowIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              SeatLayoutHelper.cols,
              (colIndex) {
                if (!SeatLayoutHelper.shouldRenderSeat(rowIndex, colIndex)) {
                  return const SizedBox(width: seatSize);
                }

                return Container(
                  width: seatSize,
                  height: seatSize,
                  decoration: BoxDecoration(
                    color: seatColor(rowIndex, colIndex),
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
