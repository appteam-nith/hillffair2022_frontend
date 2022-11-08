import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

class TeamFeedVideo extends StatefulWidget {
  final String videourl;
  TeamFeedVideo({super.key, required this.videourl});

  @override
  State<TeamFeedVideo> createState() => _TeamFeedVideoState();
}

class _TeamFeedVideoState extends State<TeamFeedVideo> {
  // late YoutubePlayerController _controller;
  // late VideoPlayerController _controller;
  // late Future<void> _initializerVideoPlayerFuture;
  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(widget.videourl));

    // _controller = VideoPlayerController.network(widget.videourl);
    // _initializerVideoPlayerFuture = _controller.initialize();
    // _controller.setLooping(true);
    // _controller.setVolume(1.0);

    // final videoid = YoutubePlayer.convertUrlToId(widget.videourl);

    // _controller = YoutubePlayerController(
    //     initialVideoId: videoid!,
    //     flags: const YoutubePlayerFlags(
    //       autoPlay: false,
    //     ));
    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       if (_controller.value.isPlaying) {
      //         _controller.pause();
      //       } else {
      //         _controller.play();
      //       }
      //     });
      //   },
      //   child: Icon(
      //       _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      // ),
      backgroundColor: bgColor,

      body: Container(
        child: FlickVideoPlayer(flickManager: flickManager),
      ),

      // body: FutureBuilder(
      //   future: _initializerVideoPlayerFuture,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       return Center(
      //         child: AspectRatio(
      //           aspectRatio: _controller.value.aspectRatio,
      //           // aspectRatio: 16 / 9,
      //           child: Stack(
      //             children: [
      //               VideoPlayer(_controller),
      //               VideoProgressIndicator(_controller, allowScrubbing: true)
      //             ],
      //           ),
      //         ),
      //       );
      //     } else {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },

      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     YoutubePlayer(
      //       controller: _controller,
      //       showVideoProgressIndicator: true,
      //       onReady: () {
      //         print("ready");
      //       },
      //     )
      //   ],
      // ),
    );
  }
}
