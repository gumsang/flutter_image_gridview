import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class MediaDetail extends StatefulWidget {
  const MediaDetail(this.url, {Key? key}) : super(key: key);

  final String url;

  @override
  _MediaDetailState createState() => _MediaDetailState();
}

class _MediaDetailState extends State<MediaDetail> {
  late VideoPlayerController _controller;
  List<String> replaceUrl = [];

  @override
  void initState() {
    super.initState();
    replaceUrl = widget.url.split('https');
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _controller.play();
        setState(() {});
      });
    _controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("동영상 재생"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios))
          ],
        ),
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
