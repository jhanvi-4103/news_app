import 'package:flutter/material.dart';
import 'package:news_app/Model/news_model.dart';
import 'package:news_app/Service/news_service.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService _newsService = NewsService();

  List<NewsArticle> _articles = [];
  List<NewsArticle> get articles => _articles;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchArticles({String? query}) async {
    if (_articles.isNotEmpty && query == null) return;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final fetchedArticles = await _newsService.getArticles(query: query);
      _articles = fetchedArticles.cast<NewsArticle>();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchArticles(String query) {
    fetchArticles(query: query);
  }
}
