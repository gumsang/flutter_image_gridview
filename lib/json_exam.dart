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
                              setState(() {
                                inputText = inputController.text;
                              });
                            }
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                    if (inputText.isNotEmpty) ImageGridView(inputText, images),
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

class ImageGridView extends StatelessWidget {
  const ImageGridView(this.inputString, this.images, {Key? key})
      : super(key: key);
  final String inputString;
  final List<Map<String, dynamic>> images;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> image = images[index];
          print('GridView' + '${index}');
          print(inputString);
          if (image.containsValue(inputString)) {
            return Image.network(image['previewURL']);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class MyMap {
  final List<Map<String, dynamic>> myListMap;

  MyMap(this.myListMap);
}
