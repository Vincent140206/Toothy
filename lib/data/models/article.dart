class Article {
  final id;
  final title;
  final photo_url;
  final content;
  final created_at;
  final updated_at;

  Article({
    required this.id,
    required this.title,
    required this.photo_url,
    required this.content,
    required this.created_at,
    required this.updated_at,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      photo_url: json['photo_url'],
      content: json['content'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}