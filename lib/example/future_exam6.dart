import 'dart:math';

import 'package:flutter/material.dart';

class IncreaseCounterTime extends StatefulWidget {
  const IncreaseCounterTime({Key? key}) : super(key: key);

  @override
  State<IncreaseCounterTime> createState() => _IncreaseCounterTime();
}

class _IncreaseCounterTime extends State<IncreaseCounterTime> {
  var rnd = Random();
  int randomnumber = 0;
  bool isLoading = false;
  int increase = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("1초 증감 카운터"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                showSeconds(),
                showLoading(),
              ],
            ),
            increaseButton(),
            decreaseButton(),
            resetButton(),
          ],
        ),
      ),
    );
  }

  Widget increaseButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          increase++;
        });
        setLoading();
      },
      child: const Text("1초 증가"),
    );
  }

  Widget decreaseButton() {
    return ElevatedButton(
      onPressed: () {
        if (increase > 0) {
          setState(() {
            increase--;
          });
        } else {
          final snackBar = SnackBar(content: Text('0초보다 작을 수 없어요'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        setLoading();
      },
      child: const Text("1초 감소"),
    );
  }

  Widget resetButton() {
    return ElevatedButton(
      onPressed: () {
        setZero();
      },
      child: const Text("너무 길다. 1초로!"),
    );
  }

  Widget showLoading() {
    if (isLoading) {
      return CircularProgressIndicator();
    } else {
      return Text('$increase초 지났습니다');
    }
  }

  Widget showSeconds() {
    return Text(
      "현재 로딩중인 시간 $increase",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Future setLoading() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: increase));
    setState(() {
      isLoading = false;
    });
  }

  void setZero() {
    setState(() {
      increase = 0;
    });
    setLoading();
  }
}
