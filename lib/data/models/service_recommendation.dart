class ServiceRecommendation {
  final String id;
  final String name;
  final String description;
  final int startEstimatedPrice;
  final int endEstimatedPrice;

  ServiceRecommendation({
    required this.id,
    required this.name,
    required this.description,
    required this.startEstimatedPrice,
    required this.endEstimatedPrice,
  });

  factory ServiceRecommendation.fromJson(Map<String, dynamic> json) {
    return ServiceRecommendation(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      startEstimatedPrice: json['start_estimated_price'],
      endEstimatedPrice: json['end_estimated_price'],
    );
  }
}