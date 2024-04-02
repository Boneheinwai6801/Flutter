// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMov extends StatefulWidget {
  String mov;
  DetailMov(this.mov, {super.key});

  @override
  State<DetailMov> createState() => _DetailMovState();
}

class _DetailMovState extends State<DetailMov> {
  late YoutubePlayerController _controller;
  bool isLoading = false;
  bool isFullscreen = false;
  playVideo() {
    final videoId = YoutubePlayer.convertUrlToId(widget.mov);
    _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
            autoPlay: true, mute: false, showLiveFullscreenButton: false));
  }

  @override
  void initState() {
    super.initState();
    playVideo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
