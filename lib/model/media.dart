class Media {
  final String tags;
  final String pictureId; //썸네일
  final String thumbnailSize = '960x540';
  final String mediaUrl;
  final String views;
  final String likes;
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
