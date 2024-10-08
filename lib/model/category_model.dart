class CategoryModel {
  late String id,
      collectionId,
      category,
      content,
      poster,
      imagePath,
      smallTitle;

  CategoryModel(
      {required this.id,
      required this.collectionId,
      required this.category,
      required this.content,
      required this.poster,
      required this.imagePath,
      required this.smallTitle});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    String id = json['id'];
    String collectionId = json['collectionId'];
    String imagePath = json['image'];
    String posterPath = json['poster'];
    String fullImageUrl =
        'https://dark-master.pockethost.io/api/files/$collectionId/$id/$imagePath';
    String fullPosterUrl =
        'https://dark-master.pockethost.io/api/files/$collectionId/$id/$posterPath';

    return CategoryModel(
      id: id,
      collectionId: collectionId,
      category: json['category'] ?? '',
      content: json['content'] ?? '',
      poster: fullPosterUrl ?? '',
      imagePath: fullImageUrl ?? '',
      smallTitle: json['small_title'],
    );
  }
}
