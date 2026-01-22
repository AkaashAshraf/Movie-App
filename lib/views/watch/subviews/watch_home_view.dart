import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/views/watch/watch_details_view.dart';
import 'package:movie_app/views/widgets/featured_movie_card.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/watch_viewmodel.dart';
import '../../../core/constants/app_colors.dart';

class WatchHomeView extends StatelessWidget {
  const WatchHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WatchViewModel>();

    return SafeArea(
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: _buildBody(vm, context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.pureWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Watch',
              style: TextStyle(
                color: AppColors.darkPurple,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<WatchViewModel>().goToSearch();
              },
              icon: const Icon(Icons.search, color: AppColors.darkPurple),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(WatchViewModel vm, BuildContext context) {
    if (vm.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (vm.error != null) {
      return _ErrorState(
        message: vm.error!,
        onRetry: vm.retry,
      );
    }

    if (vm.movies.isEmpty) {
      return const Center(
        child: Text(
          'No movies found',
          style: TextStyle(color: AppColors.grey),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        vm.retry();
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: vm.movies.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final movie = vm.movies[index];
          return FeaturedMovieCard(
            title: movie.title,
            imageUrl: movie.imageUrl,
            onTap: () {
              vm.openDetails(context, movie.id);
            },
          );
        },
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: const TextStyle(color: AppColors.grey),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
