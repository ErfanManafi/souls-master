class LocationModel {
  String? id, collectionId, title, type, location, image, content;
  LocationModel(
      {required this.id,
      required this.collectionId,
      required this.title,
      required this.type,
      required this.location,
      required this.image,
      required this.content});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    String collectionId = json['collectionId'];
    String id = json['id'];
    String imagePath = json['image'];
    String fullImageUrl =
        'https://dark-master.pockethost.io/api/files/$collectionId/$id/$imagePath';

    return LocationModel(
      id: id,
      collectionId: collectionId,
      image: fullImageUrl,
      title: json['title'] ?? '',
      type: json['type'],
      location: json['location'],
      content: json['content'],
    );
  }
}
