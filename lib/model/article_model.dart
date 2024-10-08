class ArticleModel {
  late String id,
      collectionId,
      title,
      bossName,
      type,
      image,
      info,
      strategy,
      attack;

  ArticleModel({
    required this.id,
    required this.collectionId,
    required this.title,
    required this.bossName,
    required this.type,
    required this.image,
    required this.info,
    required this.strategy,
    required this.attack,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    // Use the JSON data directly to construct the full image URL
    String collectionId = json['collectionId'];
    String id = json['id'];
    String imagePath = json['image'];
    String fullImageUrl =
        'https://dark-master.pockethost.io/api/files/$collectionId/$id/$imagePath';

    return ArticleModel(
      id: id,
      collectionId: collectionId,
      title: json['title'] ?? '',
      bossName: json['boss_name'] ?? '',
      type: json['type'],
      image: fullImageUrl, // Use the full URL
      info: json['info'] ?? '',
      strategy: json['strategy'] ?? '',
      attack: json['attacks'] ?? '',
    );
  }
}
