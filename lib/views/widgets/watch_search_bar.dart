import 'package:flutter/material.dart';
import 'package:movie_app/views/watch/states/watch_ui_state.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../viewmodels/watch_viewmodel.dart';

class WatchSearchBar extends StatelessWidget {
  const WatchSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WatchViewModel>();

    final bool isOnSearchScreen = vm.state == WatchUIState.searchEmpty;
    final bool isSearchEmpty = vm.searchQuery.isEmpty;

    return Container(
      color: AppColors.pureWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.grey),
                    const SizedBox(width: 8),

                    Expanded(
                      child: TextField(
                        controller: vm.searchController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Tv shows, movies and more',
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                        onChanged: vm.onSearchChanged,
                      ),
                    ),

                    // SAME ICON — different behavior
                    GestureDetector(
                      onTap: () {
                        if (isOnSearchScreen && isSearchEmpty) {
                          // Screen 2 + empty → go home
                          vm.goToHome();
                        } else if (!isSearchEmpty) {
                          // Clear text
                          vm.clearSearch();
                        }
                      },
                      child: Icon(
                        Icons.close,
                        color: (isOnSearchScreen && isSearchEmpty)
                            ? AppColors.darkPurple
                            : AppColors.grey,
                      ),
                    ),
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
