import 'dart:math';

import 'package:flutter/material.dart';

class YourExLife extends StatefulWidget {
  const YourExLife({Key? key}) : super(key: key);

  @override
  State<YourExLife> createState() => _YourExLifeState();
}

class _YourExLifeState extends State<YourExLife> {
  var rnd = Random();
  int randomnumber = 0;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("전생앱"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "당신의 전생은",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Column(
              children: [
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  Text('$randomnumber'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                showExLife();
                showLoading();
              },
              child: Text("전생 알아보기"),
            ),
          ],
        ),
      ),
    );
  }

  void showExLife() async {
    setState(() {
      isLoading = true;
    });
  }

  Future showLoading() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isLoading = false;
      randomnumber = rnd.nextInt(100);
    });
  }
}
