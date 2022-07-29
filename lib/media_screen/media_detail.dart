import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import 'components/view_details.dart';
import 'model/media.dart';

class MediaDetail extends StatefulWidget {
  const MediaDetail(this.media, {Key? key}) : super(key: key);

  final Media media;

  @override
  State<MediaDetail> createState() => _MediaDetailState();
}

class _MediaDetailState extends State<MediaDetail> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.media.mediaUrl)
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
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[800],
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text("동영상 재생"),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  child: _controller.value.isInitialized
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                });
                              },
                              child: AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              ),
                            ),
                            SizedBox(
                              width: 85,
                              height: 85,
                              child: _controller.value.isPlaying
                                  ? const SizedBox()
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _controller.value.isPlaying
                                              ? _controller.pause()
                                              : _controller.play();
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.play_circle,
                                        size: 80,
                                      ),
                                    ),
                            ),
                          ],
                        )
                      : const SizedBox(
                          width: 200,
                          height: 200,
                          child: CircularProgressIndicator(),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ViewDetails(widget.media),
                ),
              ],
            ),
          ],
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
