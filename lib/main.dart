import 'package:exam_1/media_search.dart';
import 'package:flutter/material.dart';
import 'json_exam.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const JsonExam(), //이미지검색
        '/media': (context) => const MediaSearch(), //동영상검색
      },
      initialRoute: '/',
    );
  }
}
