import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

class TeamFeedVideo extends StatefulWidget {
  final String videourl;
  final double volume;
  TeamFeedVideo({super.key, required this.videourl, required this.volume});

  @override
  State<TeamFeedVideo> createState() => _TeamFeedVideoState();
}

class _TeamFeedVideoState extends State<TeamFeedVideo> {
  late FlickManager flickManager;

  @override
  void initState() {
    var x = VideoPlayerController.network(
      widget.videourl,
    );
    x.setLooping(true);
    x.setVolume(widget.volume);
    flickManager = FlickManager(videoPlayerController: x);
    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlickVideoPlayer(
      flickManager: flickManager,
      flickVideoWithControls:
          FlickVideoWithControls(videoFit: BoxFit.contain),
    );
  }
}
