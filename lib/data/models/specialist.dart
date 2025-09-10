class Specialists {
  final int id;
  final String title;

  Specialists({
    required this.id,
    required this.title,
  });

  factory Specialists.fromJson(Map<String, dynamic> json) {
    return Specialists(
      id: json['id'],
      title: json['title'],
    );
  }
}