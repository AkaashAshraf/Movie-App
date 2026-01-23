import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/helper.dart';
import 'package:movie_app/views/seats/seat_selection_view.dart';
import 'package:movie_app/views/widgets/seats/showtime_card.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../viewmodels/watch_viewmodel.dart';

class ShowtimeSelectionView extends StatefulWidget {
  const ShowtimeSelectionView({super.key});

  @override
  State<ShowtimeSelectionView> createState() => _ShowtimeSelectionViewState();
}

class _ShowtimeSelectionViewState extends State<ShowtimeSelectionView> {
  int selectedDateIndex = 0;
  int? selectedShowtimeIndex;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WatchViewModel>();
    final movie = vm.selectedMovieDetails;

    if (movie == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final DateTime releaseDate = DateTime.parse(movie.releaseDate);

    final dates = _generateDates(releaseDate);

    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        backgroundColor: AppColors.pureWhite,
        elevation: 0,
        leading: const BackButton(color: AppColors.darkPurple),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              movie.title,
              style: const TextStyle(
                color: AppColors.darkPurple,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'In Theaters ${DateFormatter.format(movie.releaseDate)}',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.skyBlue,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Date',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkPurple,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final date = dates[index];
                final isSelected = index == selectedDateIndex;

                return GestureDetector(
                  onTap: () {
                    setState(() => selectedDateIndex = index);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.skyBlue
                          : AppColors.lightGrey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      formatShortDate(date),
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.pureWhite
                            : AppColors.darkPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 2,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final isSelected = selectedShowtimeIndex == index;

                final time = index == 0 ? '12:30' : '13:30';
                final hall = index == 0 ? 'Cinetech + Hall 1' : 'Cinetech';
                final price = index == 0
                    ? 'From 50\$ or 2500 bonus'
                    : 'From 75\$ or 3000 bonus';

                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ShowtimeCard(
                    time: time,
                    hall: hall,
                    priceText: price,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        selectedShowtimeIndex = index;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider.value(
                            value: vm,
                            child: const SeatSelectionView(),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<DateTime> _generateDates(DateTime releaseDate) {
    return List.generate(
      7,
      (i) => releaseDate.add(Duration(days: i + 1)),
    );
  }
}
