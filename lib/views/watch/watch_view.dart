import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/watch_viewmodel.dart';
import 'states/watch_ui_state.dart';
import 'subviews/watch_home_view.dart';
import 'subviews/watch_results_view.dart';
import 'subviews/watch_final_results_view.dart';
import 'subviews/watch_categories_view.dart';

class WatchView extends StatelessWidget {
  const WatchView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WatchViewModel>();

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: _buildBody(vm),
      ),
    );
  }

  Widget _buildBody(WatchViewModel vm) {
    switch (vm.state) {
      case WatchUIState.home:
        return const WatchHomeView();

      case WatchUIState.searchEmpty:
        return const WatchCategoriesView();

      case WatchUIState.results:
        return const WatchResultsView();

      case WatchUIState.finalResults:
        return const WatchFinalResultsView();
    }
  }
}
