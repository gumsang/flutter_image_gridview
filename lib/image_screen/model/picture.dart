import 'dart:async';

class Picture {
  final String previewUrl;
  final String tags;

  Picture({required this.previewUrl, required this.tags});
  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      previewUrl: json['previewURL'] as String,
      tags: json['tags'] as String,
    );
  }
}
