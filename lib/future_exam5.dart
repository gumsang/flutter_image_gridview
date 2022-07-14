import 'dart:math';

import 'package:flutter/material.dart';

class YourExLife extends StatefulWidget {
  const YourExLife({Key? key}) : super(key: key);

  @override
  State<YourExLife> createState() => _YourExLifeState();
}

class _YourExLifeState extends State<YourExLife> {
  // var rnd = Random();
  int randomnumber = 0;
  bool isLoading = false;
  List myList = ['홍길동', '유비', '관우', '장비'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("전생앱"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showText(),
            Column(
              children: [
                showLoading(),
              ],
            ),
            randomButton(),
          ],
        ),
      ),
    );
  }

  Widget showText() {
    return const Text(
      "당신의 전생은",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    );
  }

  Widget randomButton() {
    return ElevatedButton(
      onPressed: () {
        setLoading();
      },
      child: const Text("전생 알아보기"),
    );
  }

  Widget showLoading() {
    if (isLoading)
      return CircularProgressIndicator();
    else
      return Text('${myList[randomnumber]}');
  }

  Future setLoading() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isLoading = false;
      // randomnumber = rnd.nextInt(3);
      randomnumber = Random().nextInt(3);
    });
  }
}
