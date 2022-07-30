import 'dart:async';
import 'package:flutter/material.dart';
import 'api/picture_api.dart';
import 'model/picture.dart';

class ImageSearch extends StatefulWidget {
  ImageSearch({Key? key}) : super(key: key);

  @override
  State<ImageSearch> createState() => _ImageSearchState();
}

class _ImageSearchState extends State<ImageSearch> {
  final _pictureApi = PictureApi();
  String inputText = '';
  final inputController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색'),
        backgroundColor: Theme.of(context).colorScheme.primary,
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
                    } else {
                      _pictureApi.fetchImages(inputController.text);
                    }
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
            StreamBuilder(
              initialData: [],
              stream: _pictureApi.imeagesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('에러가 발생했습니다'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('데이터가 없습니다'),
                  );
                }

                return ImageGridView(_pictureApi.imageList, inputText);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ImageGridView extends StatefulWidget {
  const ImageGridView(this.images, this.inputText, {Key? key})
      : super(key: key);
  final List<Picture> images;
  final String inputText;

  @override
  State<ImageGridView> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Expanded(
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              orientation == Orientation.portrait ? 2 : 4, //1 개의 행에 보여줄 item 개수
          childAspectRatio: 1 / 1, //item 의 가로 1, 세로 2 의 비율
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        children: widget.images
            .where((element) => element.tags.contains(widget.inputText))
            .map(
          (Picture image) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                image.previewUrl,
                fit: BoxFit.cover,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
