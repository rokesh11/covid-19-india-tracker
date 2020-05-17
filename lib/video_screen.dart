import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoBox extends StatefulWidget {
  final videoId;

  VideoBox({this.videoId});
  @override
  _VideoBoxState createState() => _VideoBoxState();
}

class _VideoBoxState extends State<VideoBox> {
  YoutubePlayerController _controller;
  //Future<void> futureController;

  @override
  void initState() {
    super.initState();
    _controller =YoutubePlayerController(
        initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop:true,
      ),
    );
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Covid19 India Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           YoutubePlayer(
             controller: _controller,
            showVideoProgressIndicator: true,
             progressIndicatorColor: Colors.red,
           ),
          ],
        ),
      ),
    );
  }
}
