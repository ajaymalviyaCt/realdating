// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:realdating/function/function_class.dart';
// import 'package:realdating/pages/video_screen/video_controller.dart';
//
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoPlayerItem extends StatefulWidget {
//   final String videoUrl;
//
//   const VideoPlayerItem({
//     Key? key,
//     required this.videoUrl,
//   }) : super(key: key);
//
//   @override
//   _VideoPlayerItemState createState() => _VideoPlayerItemState();
// }
//
// class _VideoPlayerItemState extends State<VideoPlayerItem> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//   VideoController videoController = Get.put(VideoController());
//   ChewieController? _chewieController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     setState(() {
//       _controller = VideoPlayerController.networkUrl(
//         Uri.parse(
//           widget.videoUrl,
//         ),
//       );
//       _initializeVideoPlayerFuture = _controller.initialize();
//
//     });
//   }
//
//
//   @override
//   void dispose() {
//     videoController.load.value = false;
//     super.dispose();
//     _controller.dispose();
//     _chewieController?.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Container(
//         width: size.width,
//         height: size.height,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//         ),
//         child: Stack(
//           children: [
//             SizedBox(
//               width: double.infinity,
//               child: FutureBuilder(
//                 future: _initializeVideoPlayerFuture,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     return AspectRatio(
//                       aspectRatio: _controller.value.aspectRatio,
//                       child: VideoPlayer(_controller),
//                     );
//                   } else {
//                     return const Center(
//                       child: CircularProgressIndicator(strokeWidth: 2,),
//                     );
//                   }
//                 },
//               ),
//             ),
//             Center(
//               child: FutureBuilder(
//                 future: _initializeVideoPlayerFuture,
//                 builder: (context, snapshot) {
//                   if (_controller.value.isInitialized ) {
//                     return FloatingActionButton(
//                       backgroundColor: Appcolor.Redpink,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(100)),
//                       mini: true,
//                       onPressed: () {
//                         setState(() {
//                           if (_controller.value.isPlaying) {
//                             _controller.pause();
//                           } else {
//                             _controller.play();
//                           }
//                         });
//                       },
//                       child: Icon(
//                         _controller.value.isPlaying
//                             ? Icons.pause
//                             : Icons.play_arrow,
//                         color: Colors.white,
//                       ),
//                     );
//                   } else {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 },
//               ),
//             )
//           ],
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:realdating/function/function_class.dart';
import 'package:realdating/pages/video_screen/video_controller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerItem({
    super.key,
    required this.videoUrl,
  });

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  VideoController videoController = Get.put(VideoController());

  @override
  void initState() {
    super.initState();

    setState(() {
      _controller = VideoPlayerController.network(
        widget.videoUrl,
      );
      _initializeVideoPlayerFuture = _controller.initialize();
      _controller.addListener(() {
        if (_controller.value.position == _controller.value.duration) {
          // Video has reached the end, pause it
          _controller.pause();
          // Optionally, you can seek to the beginning to restart the video
          //_controller.seekTo(Duration.zero);
        }
        setState(() {}); // Update the UI whenever the video state changes
      });
    });
  }

  @override
  void dispose() {
    videoController.load.value = false;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                }
              },
            ),
          ),
          Center(
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (_controller.value.isInitialized) {
                  return FloatingActionButton(
                    backgroundColor: Appcolor.Redpink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    mini: true,
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),

          /* Center(
            child: FloatingActionButton(
              backgroundColor: Appcolor.Redpink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              mini: true,
              onPressed: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
