//
//
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// //
// // class VideoItem {
// //   final String videoUrl;
// //   final String title;
// //
// //   VideoItem({required this.videoUrl, required this.title});
// // }
// //
// // class MyApp222 extends StatelessWidget {
// //
// //   final List<VideoItem> videoList = [
// //     VideoItem(videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4', title: 'Video 1'),
// //     VideoItem(videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4', title: 'Video 2'),
// //     VideoItem(videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4', title: 'Video 2'),
// //     VideoItem(videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4', title: 'Video 2'),
// //     VideoItem(videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4', title: 'Video 2'),
// //     VideoItem(videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4', title: 'Video 2'),
// //     // Add more video items as needed
// //   ];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Video List Example'),
// //         ),
// //         body: ListView.builder(
// //           itemCount: videoList.length,
// //           itemBuilder: (context, index) {
// //             return Container(
// //                  height: 200,width: 200,
// //                 child: VideoListItem(videoItem: videoList[index]));
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// class VideoListItem extends StatefulWidget {
//   final VideoItem videoItem;
//
//     VideoListItem({required this.videoItem});
//
//   @override
//   _VideoListItemState createState() => _VideoListItemState();
// }
//
// class _VideoListItemState extends State<VideoListItem> {
//   late VideoPlayerController _videoPlayerController;
//   late ChewieController _chewieController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _videoPlayerController = VideoPlayerController.network(widget.videoItem.videoUrl);
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       aspectRatio: 16 / 9, // Adjust as needed
//       autoInitialize: true,
//       looping: false,
//       errorBuilder: (context, errorMessage) {
//         return Center(
//           child: Text(errorMessage),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: [
//           Chewie(
//             controller: _chewieController,
//           ),
//           ListTile(
//             title: Text(widget.videoItem.title),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }
// }


import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyApp222 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideoListScreen(),
    );
  }
}

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {

  List<VideoPlayerController> controllers = [
    VideoPlayerController.network('https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4'),
    VideoPlayerController.network('https://vod-progressive.akamaized.net/exp=1705332866~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F4465%2F14%2F372327760%2F1547056590.mp4~hmac=803443c9ce099a090713bdf6fe7482e3397b09790cad92a908d66c3b4c3fcf70/vimeo-prod-skyfire-std-us/01/4465/14/372327760/1547056590.mp4'),
    VideoPlayerController.network('https://player.vimeo.com/external/473575666.hd.mp4?s=2eefbe7e377c8f421a6a5e77de8ec4150e35dbb1&profile_id=175&oauth2_token_id=57447761'),
    // Add more video URLs as needed
  ];

  @override
  void initState() {
    super.initState();
    controllers.forEach((controller) {
      controller.initialize().then((_) {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    controllers.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video List'),
      ),
      body: ListView.builder(
        itemCount: controllers.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              controllers[index].play();
            },
            child: Card(
              child: ListTile(
                title: Text('Video ${index + 1}'),
                subtitle: AspectRatio(
                  aspectRatio: controllers[index].value.aspectRatio,
                  child: VideoPlayer(controllers[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
// final List<VideoItem> videoList = [
//   VideoItem(videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4', title: 'Video 1'),
//   VideoItem(videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4', title: 'Video 2'),
//   VideoItem(videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4', title: 'Video 2'),
//   VideoItem(videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4', title: 'Video 2'),
//   VideoItem(videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4', title: 'Video 2'),
//   VideoItem(videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4', title: 'Video 2'),
//   // Add more video items as needed
// ];






//
//
//
//
// class VideoPlayerScreen extends StatefulWidget {
//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }
//
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(
//       'https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_1mb.mp4',
//       videoPlayerOptions: VideoPlayerOptions()
//     )..initialize().then((_) {
//       // Ensure the first frame is shown after the video is initialized
//       setState(() {});
//     });
//
//     // Add a listener to update the UI when the video has completed playing
//     _controller.addListener(() {
//       if (_controller.value.position == _controller.value.duration) {
//         setState(() {
//           _isPlaying = false;
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     // Ensure you dispose of the VideoPlayerController when the widget is disposed
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Player Example'),
//       ),
//       body: Center(
//         child: _controller.value.isInitialized
//             ? AspectRatio(
//           aspectRatio: _controller.value.aspectRatio,
//           child: VideoPlayer(_controller),
//         )
//             : CircularProgressIndicator(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             if (_isPlaying) {
//               _controller.pause();
//             } else {
//               _controller.play();
//             }
//             _isPlaying = !_isPlaying;
//           });
//         },
//         child: Icon(
//           _isPlaying ? Icons.pause : Icons.play_arrow,
//         ),
//       ),
//     );
//   }
// }
