import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  VideoPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: new Chewie(
        new VideoPlayerController.network(
            'https://static.sucaihuo.com/jquery/28/2827/demo/media/mov_bbb.mp4'),
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: true,
      ),
    );
  }
}
