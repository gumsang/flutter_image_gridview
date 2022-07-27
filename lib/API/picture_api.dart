import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:exam_1/model/picture.dart';

class PictureApi {
  Future<List<Picture>> getImages(String inputText) async {
    Uri url = Uri.parse(
        'https://pixabay.com/api/?key=10711147-dc41758b93b263957026bdadb&q=$inputText&image_type=photo');

    http.Response response = await http.get(url);
    String jsonString = response.body;

    Map<String, dynamic> json = jsonDecode(jsonString);
    Iterable hits = json['hits'];
    return hits.map((e) => Picture.fromJson(e)).toList();
  }
}
