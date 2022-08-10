import 'package:exam_1/image_screen/api/picture_api.dart';
import 'package:flutter/material.dart';

import 'picture.dart';

class ImageSearchViewModel extends ChangeNotifier {
  final _pictureApi = PictureApi();

  List<Picture> imageList = [];

  void fetchImages(String query) async {
    imageList = await _pictureApi.getImages(query);

    notifyListeners();
  }
}
