import 'package:toothy/data/models/service_recommendation.dart';

class Report {
  final String id;
  final String userId;
  final String? frontTeethPhotoUrl;
  final String? upperTeethPhotoUrl;
  final String? lowerTeethPhotoUrl;
  final String? additionalDescription;
  final String summary;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ServiceRecommendation> recommendations;

  Report({
    required this.id,
    required this.userId,
    this.frontTeethPhotoUrl,
    this.upperTeethPhotoUrl,
    this.lowerTeethPhotoUrl,
    this.additionalDescription,
    required this.summary,
    required this.createdAt,
    required this.updatedAt,
    required this.recommendations,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      userId: json['user_id'],
      frontTeethPhotoUrl: json['front_teeth_photo_url'],
      upperTeethPhotoUrl: json['upper_teeth_photo_url'],
      lowerTeethPhotoUrl: json['lower_teeth_photo_url'],
      additionalDescription: json['additional_description'],
      summary: json['summary'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      recommendations: (json['report_service_recommendations'] as List<dynamic>)
          .map((e) => ServiceRecommendation.fromJson(e))
          .toList(),
    );
  }
}
