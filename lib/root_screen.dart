import 'package:flutter/material.dart';
import 'color_schemes.g.dart';
import 'image_screen/image_search.dart';
import 'main_screen/main_screen.dart';
import 'media_screen/media_search.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

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
        '/image': (context) => ImageSearch(), //이미지검색
      },
      initialRoute: '/',
    );
  }
}
