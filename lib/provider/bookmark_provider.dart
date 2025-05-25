import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_app/Model/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkProvider extends ChangeNotifier {
  List<NewsArticle> _bookmarks = [];

  List<NewsArticle> get bookmarks => _bookmarks;

  BookmarkProvider() {
    _loadBookmarks();
  }

  void addBookmark(NewsArticle article) {
    if (!_bookmarks.any((a) => a.url == article.url)) {
      _bookmarks.add(article);
      _saveBookmarks();
      notifyListeners();
    }
  }

  void removeBookmark(NewsArticle article) {
    _bookmarks.removeWhere((a) => a.url == article.url);
    _saveBookmarks();
    notifyListeners();
  }

  bool isBookmarked(NewsArticle article) =>
      _bookmarks.any((a) => a.url == article.url);

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = _bookmarks.map((e) => jsonEncode(_newsToMap(e))).toList();
    await prefs.setStringList('bookmarks', encoded);
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('bookmarks') ?? [];
    _bookmarks = list.map((e) => _mapToNews(jsonDecode(e))).toList();
    notifyListeners();
  }

  // Custom serialization helper (because original model lacks toMap/fromMap)
  Map<String, dynamic> _newsToMap(NewsArticle article) => {
    'title': article.title,
    'description': article.description,
    'urlToImage': article.urlToImage,
    'url': article.url,
    'sourceName': article.sourceName,
    'publishedAt': article.publishedAt.toIso8601String(),
  };

  NewsArticle _mapToNews(Map<String, dynamic> map) => NewsArticle(
    title: map['title'],
    description: map['description'],
    urlToImage: map['urlToImage'],
    url: map['url'],
    sourceName: map['sourceName'],
    publishedAt: DateTime.parse(map['publishedAt']),
  );
}
