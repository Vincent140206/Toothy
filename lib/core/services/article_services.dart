import 'package:dio/dio.dart';
import 'package:toothy/data/models/article.dart';

import '../constants/url.dart';
import 'dio_client.dart';

class ArticleServices {
  final dioClient = DioClient();
  Urls urls = Urls();

  Future<List<Article>> getArticles() async {
    try {
      final response = await dioClient.dio.get(Urls.getArticles);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch articles');
      }
    } catch (e) {
      print("Error getArticles: $e");
      throw Exception('Failed to fetch articles');
    }
  }

  Future<Article?> getArticleById(String id) async {
    try {
      final response = await dioClient.dio.get(Urls.getSpecificArticles + id);

      if (response.statusCode == 200) {
        final data = response.data['data'];
        return Article.fromJson(data);
      } else {
        throw Exception('Failed to fetch article');
      }
    } catch (e) {
      print("Error getArticleById: $e");
      throw Exception('Failed to fetch article');
    }
  }
}
