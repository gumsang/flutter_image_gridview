import 'package:exam_1/API/picture_api.dart';
import 'package:exam_1/model/picture.dart';
import 'package:flutter/material.dart';

class ImageSearch extends StatefulWidget {
  const ImageSearch({Key? key}) : super(key: key);

  @override
  State<ImageSearch> createState() => _ImageSearchState();
}

class _ImageSearchState extends State<ImageSearch> {
  final _pictureApi = PictureApi();
  String inputText = '';
  final inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색'),
        backgroundColor: Theme.of(context).colorScheme.primary,
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
              // otherAccountsPictures: const <Widget>[
              //   // 다른 계정 이미지[] set
              //   CircleAvatar(
              //     // backgroundColor: Colors.white,
              //     backgroundImage: NetworkImage(
              //         "https://lh3.googleusercontent.com/AKdZBBvJ1loAVmWD1RpXfh1hoKlBPTznBAMH8bH4ebMcMG-qExehI5uyVVgUP61ajiszyGHQ16O2c1lPq2XKJj6Waz1FxDy7c-y4s9n824pj5vs=s0"),
              //   ),
              // ],
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
                Navigator.pop(context);
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
      body: GestureDetector(
        // onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            TextField(
              controller: inputController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: '검색어를 입력하세요',
                suffixIcon: IconButton(
                  onPressed: () {
                    if (inputController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Text('데이터를 입력해주세요'),
                          );
                        },
                      );
                    } else {
                      setState(() {
                        inputText = inputController.text;
                      });
                    }
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
            FutureBuilder(
              future: _pictureApi.getImages(inputText),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('에러가 발생했습니다'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('데이터가 없습니다'),
                  );
                }

                final images = snapshot.data! as List<Picture>;

                return ImageGridView(images, inputText);
              },
            )
          ],
        ),
      ),
    );
  }
}

class ImageGridView extends StatefulWidget {
  ImageGridView(this.images, this.inputText, {Key? key}) : super(key: key);
  List<Picture> images;
  String inputText;

  @override
  State<ImageGridView> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Expanded(
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              orientation == Orientation.portrait ? 2 : 4, //1 개의 행에 보여줄 item 개수
          childAspectRatio: 1 / 1, //item 의 가로 1, 세로 2 의 비율
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        children: widget.images
            .where((element) => element.tags.contains(widget.inputText))
            .map(
          (Picture image) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                image.previewUrl,
                fit: BoxFit.cover,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
