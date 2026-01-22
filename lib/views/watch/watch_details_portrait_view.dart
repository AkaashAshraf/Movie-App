import 'package:flutter/material.dart';
import 'package:movie_app/views/widgets/genre_chip.dart';
import 'package:movie_app/views/widgets/loading_incator.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../viewmodels/watch_viewmodel.dart';

class WatchDetailsPortraitView extends StatelessWidget {
  const WatchDetailsPortraitView({super.key});

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
      appBar: vm.isLoading ? AppBar() : null,
      body: vm.isLoading
          ? const LoadingIndicator()
          : Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: double.infinity,
                  child: Image.network(
                    movie.backdropUrl,
                    fit: BoxFit.cover,
                  ),
                ),

                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.darkPurple.withOpacity(0.9),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                // Back button
                SafeArea(
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.offWhite,
                    ),
                  ),
                ),

                // Top info
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.38,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Text(
                        'In Theaters ${DateFormatter.format(movie.releaseDate)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.pureWhite,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.skyBlue,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Get Tickets',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.pureWhite,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: AppColors.skyBlue,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                vm.openTrailer(context);
                              },
                              icon: const Icon(
                                Icons.play_arrow,
                                color: AppColors.pureWhite,
                              ),
                              label: const Text(
                                'Watch Trailer',
                                style: TextStyle(
                                  color: AppColors.pureWhite,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Bottom sheet
                Positioned.fill(
                  top: MediaQuery.of(context).size.height * 0.6,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Genres',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkPurple,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: movie.genres.map((g) {
                              return GenreChip(
                                label: g,
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Overview',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkPurple,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.overview,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.6,
                              color: AppColors.grey,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
