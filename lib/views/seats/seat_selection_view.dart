import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/views/widgets/seats/bottom_price_bar.dart';
import 'package:movie_app/views/widgets/seats/seat_grid.dart';
import 'package:movie_app/views/widgets/seats/seat_legend.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../viewmodels/watch_viewmodel.dart';

class SeatSelectionView extends StatelessWidget {
  const SeatSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WatchViewModel>();
    final movie = vm.selectedMovieDetails;

    if (movie == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        backgroundColor: AppColors.pureWhite,
        elevation: 0,
        leading: const BackButton(color: AppColors.darkPurple),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style: const TextStyle(
                color: AppColors.darkPurple,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${DateFormatter.format(movie.releaseDate)} | Hall 1',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.skyBlue,
              ),
            ),
          ],
        ),
      ),
      body: const Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: CustomPaint(painter: ScreenPainter()),
                ),
                SizedBox(height: 4),
                Text(
                  "SCREEN",
                  style: TextStyle(fontSize: 12, color: AppColors.grey),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(child: SeatGrid()),
          SeatLegend(),
          BottomPriceBar(),
        ],
      ),
    );
  }
}

class ScreenPainter extends CustomPainter {
  const ScreenPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.skyBlue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(
        size.width / 2,
        0,
        size.width,
        size.height,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
