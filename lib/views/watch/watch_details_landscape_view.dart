import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/core/utils/date_formatter.dart';
import 'package:movie_app/views/seats/show_time_selection_view.dart';
import 'package:movie_app/views/widgets/watch/genre_chip.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../viewmodels/watch_viewmodel.dart';

class WatchDetailsLandscapeView extends StatefulWidget {
  const WatchDetailsLandscapeView({super.key});

  @override
  State<WatchDetailsLandscapeView> createState() =>
      _WatchDetailsLandscapeViewState();
}

class _WatchDetailsLandscapeViewState extends State<WatchDetailsLandscapeView> {
  final String noImageUrl = ApiConstants.noImageUrl;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WatchViewModel>();
    final movie = vm.selectedMovieDetails;

    if (movie == null) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      movie.posterUrl.isNotEmpty ? movie.posterUrl : noImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          noImageUrl,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
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
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'In Theaters ${DateFormatter.format(movie.releaseDate)}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.pureWhite,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 52,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.skyBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const ShowtimeSelectionView(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Get Tickets',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: SizedBox(
                                  height: 52,
                                  child: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: AppColors.pureWhite,
                                      ),
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkPurple,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Genres',
                      style: TextStyle(
                        fontSize: 18,
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
                    const SizedBox(height: 32),
                    const Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkPurple,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      movie.overview,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Divider(color: AppColors.lightGrey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
