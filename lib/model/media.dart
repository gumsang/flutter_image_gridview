class Media {
  final String tags;
  final String pictureId; //썸네일
  final String thumbnailSize = '295x166';
  final String mediaUrl;

  Media({required this.tags, required this.pictureId, required this.mediaUrl});
  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      tags: json['tags'],
      pictureId: json['picture_id'],
      mediaUrl: json['videos']['medium']['url'],
    );
  }
}
