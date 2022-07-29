import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/media.dart';

class MediaApi {
  Future<List<Media>> getMedias(String inputText) async {
    Uri url = Uri.parse(
        'https://pixabay.com/api/videos/?key=10711147-dc41758b93b263957026bdadb&q=$inputText');

    http.Response response = await http.get(url);
    String jsonString = response.body;

    Map<String, dynamic> json = jsonDecode(jsonString);
    Iterable hits = json['hits'];
    return hits.map((e) => Media.fromJson(e)).toList();
  }
}
