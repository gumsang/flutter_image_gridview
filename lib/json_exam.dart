import 'dart:convert';

import 'package:flutter/material.dart';

import 'data.dart';

class JsonExam extends StatefulWidget {
  const JsonExam({Key? key}) : super(key: key);

  @override
  State<JsonExam> createState() => _JsonExamState();
}

class _JsonExamState extends State<JsonExam> {
  Map<String, dynamic>? person;
  List<Map<String, dynamic>> images = [];
  String inputText = '';
  final inputController = TextEditingController();
  SearchResult mySearch = SearchResult();

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future initData() async {
    person = await getData();

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
      body: Center(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: person == null
              ? const CircularProgressIndicator()
              : Column(
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
                              mySearch.listInit();
                              for (int i = 0; i < images.length; i++) {
                                if (mySearch.checkValues(
                                    images[i], inputController.text)) {
                                  mySearch.addListMap(images[i]);
                                }
                              }
                              setState(() {});
                            }
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                    ImageGridView(mySearch.getListMap()),
                  ],
                ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getData() async {
    await Future.delayed(const Duration(seconds: 1));

    String jsonString = '{ "name": "홍길동", "email": "aaa@aaa.com" }';
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return jsonMap;
  }

  Future<List<Map<String, dynamic>>> getImages() async {
    await Future.delayed(const Duration(seconds: 1));

    List<Map<String, dynamic>> hits = data['hits'];
    return hits;
  }
}

class ImageGridView extends StatefulWidget {
  const ImageGridView(this.images, {Key? key}) : super(key: key);
  final List<Map<String, dynamic>> images;

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
          childAspectRatio: 1, //item 의 가로 1, 세로 2 의 비율
        ),
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> image = widget.images[index];
          return Image.network(image['previewURL']);
        }, //item 의 반목문 항목 형성
      ),
    );
  }
}

class SearchResult {
  List<Map<String, dynamic>> myList = [];

  SearchResult();
  addListMap(Map<String, dynamic> images) {
    myList.add(images);
  }

  bool checkValues(Map<String, dynamic> images, String input) {
    String myTags = '';
    myTags = images['tags'];

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

class MyMap {
  final List<Map<String, dynamic>> myListMap;

  MyMap(this.myListMap);
}
