import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("기본화면"),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                // 현재 계정 이미지 set
                backgroundImage: NetworkImage(
                  "https://lh3.googleusercontent.com/SCBatcq0DMP0UfFl437h8IU6RzXVgCxnPJWgZgargILJ44cRfA13P1_LQPv_bkx0CQRRFGdf1ZwPnXpDohRj-NAPKVogAxOizxcPaIJhteSY4DY=s0",
                ),
                // backgroundColor: Colors.white,
              ),
              accountName: Text('EUNSANG'),
              accountEmail: Text('EUNSANG@email.com'),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0))),
            ),
            ListTile(
              title: const Text('이미지 검색'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushNamed(context, '/image');
              },
            ),
            ListTile(
              title: const Text('동영상 검색'),
              onTap: () {
                Navigator.pushNamed(context, '/media');
              },
            ),
          ],
        ),
      ),
    );
  }
}
