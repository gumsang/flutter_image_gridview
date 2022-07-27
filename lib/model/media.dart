import 'package:flutter/material.dart';

class Media {
  final String tags;
  final String pictureId; //썸네일
  final String thumbnailSize = '960x540';
  final String mediaUrl;
  final int views;
  final int likes;
  final String userImageURL;
  final String user;

  Media(
      {required this.views,
      required this.likes,
      required this.user,
      required this.userImageURL,
      required this.tags,
      required this.pictureId,
      required this.mediaUrl});
  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      views: json['views'],
      likes: json['likes'],
      user: json['user'],
      userImageURL: json['userImageURL'],
      tags: json['tags'],
      pictureId: json['picture_id'],
      mediaUrl: json['videos']['medium']['url'],
    );
  }
}

class ViewTitle extends StatelessWidget {
  Media _media;

  ViewTitle(this._media, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _media.tags,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Views : ${_media.views}",
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 13,
                backgroundImage: NetworkImage(_media.userImageURL),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                _media.user,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
