class PosterModel {
  late String id, collectionId, title, readingTime, content, imagePath;
  PosterModel(
      {required this.id,
      required this.collectionId,
      required this.title,
      required this.readingTime,
      required this.content,
      required this.imagePath});

  factory PosterModel.fromJson(Map<String, dynamic> json) {
    String id = json['id'];
    String collectionId = json['collectionId'];
    String imagePath = json['image'];
    String fullImageUrl =
        'https://dark-master.pockethost.io/api/files/$collectionId/$id/$imagePath';

    return PosterModel(
      id: id,
      collectionId: collectionId,
      title: json['title'] ?? '',
      readingTime: json['reading_time'] ?? '',
      content: json['content'] ?? '',
      imagePath: fullImageUrl ?? '',
    );
  }
}
