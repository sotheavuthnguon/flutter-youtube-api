import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String id;
  const VideoScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }

  @override
  void deactivate() {
    log('deactivate is called');
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.deactivate();
  }

  @override
  void dispose() {
    log('dispose is called');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {
          log('Player is ready.');
        },
        onEnded: (_) {
          log('Player is ended');
          _controller.seekTo(const Duration(seconds: 0));
          _controller.pause();
        },
      ),
    );
  }
}
