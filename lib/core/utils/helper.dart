import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_colors.dart';
import 'package:movie_app/data/models/tmdb_video_model.dart';
import 'package:movie_app/views/widgets/seats/seat_widget.dart';

TmdbVideoModel? pickBestTrailer(List<TmdbVideoModel> videos) {
  try {
    return videos.first;
    return videos.firstWhere(
      (v) => v.type == 'Trailer' && v.official == true,
      orElse: () => videos.first,
    );
  } catch (_) {
    return null;
  }
}

class SeatLayoutHelper {
  static const int rows = 10;
  static const int cols = 22;

  static bool shouldRenderSeat(int row, int col) {
    if (col == 5 || col == cols - 6) return false;
    if ((col == 0 || col == cols - 1) && row < 4) return false;
    if ((col == 1 || col == 2 || col == cols - 2 || col == cols - 3) &&
        row == 0) {
      return false;
    }

    return true;
  }
}

SeatType mockSeatType(int row, int col) {
  if (row == 3 && col == 6) return SeatType.selected;
  if (row % 4 == 0 && col % 3 == 0) return SeatType.unavailable;
  if (row == SeatLayoutHelper.rows - 1) return SeatType.vip;
  return SeatType.regular;
}

Color seatColor(int row, int col) {
  if (row == 3 && col == 6) return AppColors.mustard;
  if (row % 4 == 0 && col % 3 == 0) {
    return AppColors.lightGrey;
  }
  if (row == SeatLayoutHelper.rows - 1) {
    return AppColors.purple;
  }
  return AppColors.skyBlue;
}

String formatShortDate(DateTime date) {
  final monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  return '${date.day} ${monthNames[date.month - 1]}';
}
