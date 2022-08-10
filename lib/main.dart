import 'package:exam_1/root_screen.dart';
import 'package:flutter/material.dart';
import 'color_schemes.g.dart';
import 'image_screen/model/image_search_view_model.dart';
import 'package:provider/provider.dart';

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
      home: ChangeNotifierProvider(
        create: (_) => ImageSearchViewModel(),
        child: const RootScreen(),
      ),
    );
  }
}
