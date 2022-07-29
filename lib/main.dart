import 'package:flutter/material.dart';
import 'color_schemes.g.dart';
import 'main_screen/main_screen.dart';
import 'media_screen/media_search.dart';
import 'picture_screen/image_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      routes: {
        '/': (context) => const MainScreen(), //이미지검색
        '/media': (context) => const MediaSearch(), //동영상검색
        '/image': (context) => const ImageSearch(), //이미지검색
      },
      initialRoute: '/',
    );
  }
}
