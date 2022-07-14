import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FutureExam extends StatelessWidget {
  const FutureExam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Future 연습'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                print(await exam1_2());
              },
              child: const Text('연습1'),
            ),
            ElevatedButton(
              onPressed: () async {
                // await exam1_2();
                int i = 0;
                for (i = 0; i < 3; i++) {
                  print(await exam2() + '$i');
                }
              },
              child: const Text('연습2'),
            ),
            ElevatedButton(
              onPressed: exam3,
              child: const Text('연습3'),
            ),
            ElevatedButton(
              onPressed: () async {
                for (int i = 5; i > 0; i--) {
                  print(i);
                  await Future.delayed(const Duration(seconds: 1));
                }
              },
              child: const Text('연습4'),
            ),
            ElevatedButton(
              onPressed: () {
                final snackBar = SnackBar(
                  content: const Text('Yay! A SnackBar!'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Text('연습5'),
            ),
          ],
        ),
      ),
    );
  }

  Future exam1() async {
    var delay = Future.delayed(const Duration(seconds: 3));

    delay.then((value) => print('world'));
  }

  Future<String> exam1_2() async {
    await Future.delayed(const Duration(seconds: 2));
    var data = await Future.value('world');

    return data;
  }

  Future<String> exam1_3() async {
    await Future.delayed(const Duration(seconds: 2));

    return 'world';
  }

  Future<String> exam2() async {
    await Future.delayed(const Duration(seconds: 1));

    return 'hello';
  }

  Future exam3() async {
    print('다운로드 시작!');
    await Future.delayed(const Duration(seconds: 1));

    print('초기화중');
    await Future.delayed(const Duration(seconds: 1));

    print('핵심 파일 로드 중');
    await Future.delayed(const Duration(seconds: 3));

    print('다운로드 완료');
  }
}
// 버튼을 누르면 다음이 print 되도록 하시오.
// —--------------
// 다운로드 시작!
// (1초 후)
// 초기화 중…
// (1초 후)
// 핵심 파일 로드 중…
// (3초 후)
// 다운로드 완료!