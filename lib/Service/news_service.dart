import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/news_model.dart';

class NewsService {
  final String _apiKey = 'd64e27898d88406287da2b914d535d98';
  final String _url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=';

  Future<List<NewsArticle>> fetchNews() async {
    final response = await http.get(Uri.parse('$_url$_apiKey'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final articles = jsonData['articles'] as List;
      return articles.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<NewsArticle>> getArticles({String? query}) async {
    final String url = query == null || query.isEmpty
        ? 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$_apiKey'
        : 'https://newsapi.org/v2/everything?q=$query&sortBy=publishedAt&apiKey=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final articles = jsonData['articles'] as List;
      return articles.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
