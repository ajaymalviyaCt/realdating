import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class Video {
  String title;
  String videoUrl;

  Video({required this.title, required this.videoUrl});
}

class MyApp22 extends StatelessWidget {
  List<Video> videoList = [
    Video(title: "Video 1", videoUrl: "https://forreal.net:4000/reels/1705667277060.mp4"),
    Video(title: "Video 2", videoUrl: "https://forreal.net:4000/reels/1705679261092.mp4"),
    Video(title: "Video 3", videoUrl: "https://forreal.net:4000/reels/1705676257972.mp4"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Video List'),
        ),
        body: VideoList(videoList: videoList),
      ),
    );
  }
}

class VideoList extends StatefulWidget {
  final List<Video> videoList;

  VideoList({required this.videoList});

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoList[0].videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.videoList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(widget.videoList[index].title),
          onTap: () {
            _controller.pause();
            _controller = VideoPlayerController.network(widget.videoList[index].videoUrl)
              ..initialize().then((_) {
                setState(() {});
                _controller.play();
              });
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
