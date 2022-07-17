import 'future_exam5.dart';
import 'package:flutter/material.dart';

import 'data.dart';
import 'future_exam.dart';
import 'future_exam6.dart';
import 'json_exam.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JsonExam(),
    );
  }
}

class CounterApp extends StatefulWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카운터'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              count++;
            });
          },
          child: Text(
            '$count',
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}
