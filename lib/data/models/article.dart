class Article {
  final String id;
  final String title;
  final String photoUrl;
  final String content;
  final String createdAt;
  final String updatedAt;

  Article({
    required this.id,
    required this.title,
    required this.photoUrl,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      photoUrl: json['photo_url'] ?? '',
      content: json['content'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'photo_url': photoUrl,
      'content': content,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
