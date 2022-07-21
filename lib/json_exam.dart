import 'dart:convert';

import 'package:flutter/material.dart';
import 'data.dart';

class JsonExam extends StatefulWidget {
  const JsonExam({Key? key}) : super(key: key);

  @override
  State<JsonExam> createState() => _JsonExamState();
}

class _JsonExamState extends State<JsonExam> {
  List<Picture> images = [];
  String inputText = '';
  final inputController = TextEditingController();
  SearchResult mySearch = SearchResult();
  bool isFirst = true;

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future initData() async {
    images = await getImages();

    // 화면 갱신
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색 뼈대'),
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
                      setState(() {
                        mySearch.listInit();
                        Picture image;
                        for (int i = 0; i < images.length; i++) {
                          image = images[i];
                          if (mySearch.checkValues(
                              image, inputController.text)) {
                            mySearch.addListMap(image);
                          }
                        }
                        isFirst = false;
                      });
                    }
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
            FutureBuilder(
              future: getImages(),
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

                final images = snapshot.data!;

                if (isFirst) {
                  return ImageGridView(images);
                } else {
                  return ImageGridView(mySearch.getListMap());
                }

                // if (images.isEmpty) {
                //   return const Center(
                //     child: Text('데이터가 0개입니다'),
                //   );
                // }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<List<Picture>> getImages() async {
    await Future.delayed(const Duration(seconds: 2));

    String jsonString = data;

    Map<String, dynamic> json = jsonDecode(jsonString);
    Iterable hits = json['hits'];
    return hits.map((e) => Picture.fromJson(e)).toList();
  }
}

class Picture {
  final String previewUrl;
  final String tags;

  Picture({required this.previewUrl, required this.tags});
  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      previewUrl: json['previewURL'] as String,
      tags: json['tags'] as String,
    );
  }
}

class ImageGridView extends StatefulWidget {
  const ImageGridView(this.images, {Key? key}) : super(key: key);
  final images;

  @override
  State<ImageGridView> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: widget.images.length, //item 개수
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
          childAspectRatio: 1 / 1, //item 의 가로 1, 세로 2 의 비율
        ),
        itemBuilder: (BuildContext context, int index) {
          Picture image = widget.images[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                image.previewUrl,
                fit: BoxFit.cover,
              ),
            ),
          );
        }, //item 의 반목문 항목 형성
      ),
    );
  }
}

class SearchResult {
  List<Picture> myList = [];

  SearchResult();
  addListMap(Picture image) {
    myList.add(image);
  }

  bool checkValues(Picture image, String input) {
    String myTags = '';
    myTags = image.tags;

    if (myTags.contains(input)) {
      return true;
    } else {
      return false;
    }
  }

  getListMap() {
    return myList;
  }

  listInit() {
    myList.clear();
  }
}
