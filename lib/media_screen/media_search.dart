import 'package:flutter/material.dart';

import 'api/media_api.dart';
import 'media_detail.dart';
import 'model/media.dart';

class MediaSearch extends StatefulWidget {
  const MediaSearch({Key? key}) : super(key: key);

  @override
  State<MediaSearch> createState() => _MediaSearchState();
}

class _MediaSearchState extends State<MediaSearch> {
  final _mediaApi = MediaApi();
  final inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('동영상 검색'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            TextField(
              controller: inputController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: '검색어를 입력하세요',
                suffixIcon: IconButton(
                  onPressed: () {
                    if (inputController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Text('데이터를 입력해주세요'),
                          );
                        },
                      );
                    }
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
            FutureBuilder(
              future: _mediaApi.getMedias(inputController.text),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('에러가 발생했습니다'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('데이터가 없습니다'),
                  );
                }

                final medias = snapshot.data! as List<Media>;

                return MediaGridView(medias, inputController.text);
              },
            )
          ],
        ),
      ),
    );
  }
}

class MediaGridView extends StatefulWidget {
  const MediaGridView(this.medias, this.inputText, {Key? key})
      : super(key: key);
  final List<Media> medias;
  final String inputText;

  @override
  State<MediaGridView> createState() => _MediaGridViewState();
}

class _MediaGridViewState extends State<MediaGridView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, //1 개의 행에 보여줄 item 개수
            childAspectRatio: 1.1 / 1, //item 의 가로 1, 세로 1 의 비율
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          children: widget.medias
              .where((element) => element.tags.contains(widget.inputText))
              .map(
            (Media media) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MediaDetail(media)));
                },
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.network(
                          "https://i.vimeocdn.com/video/${media.pictureId}_${media.thumbnailSize}.jpg",
                          fit: BoxFit.cover,
                        ),
                        const Icon(
                          Icons.play_circle,
                          size: 80,
                        ),
                      ],
                    ),
                    ViewTitle(media),
                  ],
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
