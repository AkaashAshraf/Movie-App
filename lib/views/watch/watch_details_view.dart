import 'package:flutter/material.dart';
import 'package:movie_app/views/watch/watch_details_landscape_view.dart';
import 'package:movie_app/views/watch/watch_details_portrait_view.dart';

class WatchDetailsView extends StatelessWidget {
  const WatchDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.landscape) {
      return const WatchDetailsLandscapeView();
    }

    return const WatchDetailsPortraitView();
  }
}
