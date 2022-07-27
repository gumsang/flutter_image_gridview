import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import 'model/media.dart';

class MediaDetail extends StatefulWidget {
  const MediaDetail(this.media, {Key? key}) : super(key: key);

  final Media media;

  @override
  _MediaDetailState createState() => _MediaDetailState();
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
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text("동영상 재생"),
        ),
        body: Column(
          children: [
            Container(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
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

class ViewDetails extends StatelessWidget {
  const ViewDetails(this.media, {Key? key}) : super(key: key);

  final Media media;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          media.tags,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        //********//
        //아이콘 부분//
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  const Icon(Icons.thumb_up_outlined),
                  Text(media.likes.toString()),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  Icon(Icons.remove_red_eye_outlined),
                  Text("View ${media.views.toString()}"),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: const [
                  Icon(Icons.reply_rounded),
                  Text("공유"),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: const [
                  Icon(Icons.playlist_add_outlined),
                  Text("만들기"),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: const [
                  Icon(Icons.flag_outlined),
                  Text("신고"),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: const [
                  Icon(Icons.subscriptions_outlined),
                  Text("스크립트 표시"),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: const [
                  Icon(Icons.download_outlined),
                  Text("오프라인 저장"),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
            ],
          ),
        ),
        const Divider(
          // indent: 3,
          // endIndent: 3,
          // color: Colors.black45,
          thickness: 2,
          height: 30,
        ),

        //ID
        Row(
          children: [
            SizedBox(
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(media.userImageURL),
              ),
            ),
            const SizedBox(
              width: 13,
            ),
            Expanded(
              child: Text(
                media.user,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "구독",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
