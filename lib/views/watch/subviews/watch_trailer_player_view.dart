import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../../viewmodels/watch_viewmodel.dart';
import '../../../core/constants/app_colors.dart';

class WatchTrailerPlayerView extends StatefulWidget {
  const WatchTrailerPlayerView({super.key});

  @override
  State<WatchTrailerPlayerView> createState() => _WatchTrailerPlayerViewState();
}

class _WatchTrailerPlayerViewState extends State<WatchTrailerPlayerView> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    final vm = context.read<WatchViewModel>();
    final trailer = vm.selectedTrailer;

    if (trailer != null) {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(trailer.url),
      )..initialize().then((_) {
          setState(() {
            _isInitialized = true;
          });
          _controller!.play();
          _listenForEnd();
        });
    }
  }

  void _listenForEnd() {
    _controller?.addListener(() {
      if (_controller!.value.position >= _controller!.value.duration) {
        if (mounted) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: _isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    )
                  : const CircularProgressIndicator(
                      color: AppColors.offWhite,
                    ),
            ),

            // Done Button
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
                    color: AppColors.offWhite,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
