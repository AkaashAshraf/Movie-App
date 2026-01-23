import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../viewmodels/watch_viewmodel.dart';

class WatchTrailerPlayerView extends StatefulWidget {
  const WatchTrailerPlayerView({super.key});

  @override
  State<WatchTrailerPlayerView> createState() => _WatchTrailerPlayerViewState();
}

class _WatchTrailerPlayerViewState extends State<WatchTrailerPlayerView> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    final vm = context.read<WatchViewModel>();
    final trailer = vm.selectedTrailer;

    if (trailer == null || trailer.key.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return;
    }

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );

    _controller = YoutubePlayerController(
      initialVideoId: trailer.key,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        controlsVisibleAtStart: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller!,
            showVideoProgressIndicator: true,
          ),
          builder: (context, player) {
            return Stack(
              children: [
                Center(child: player),
                Positioned(
                  top: 12,
                  right: 12,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
