import 'package:flutter/material.dart';
import 'package:news_app/provider/bookmark_provider.dart';
import 'package:news_app/tile/artical_tile.dart';
import 'package:provider/provider.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarks = context.watch<BookmarkProvider>().bookmarks;

    return Scaffold(
      body: bookmarks.isEmpty
          ? const Center(child: Text('No bookmarks yet.'))
          : ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                return NewsArticleTile(
                  article: bookmarks[index],
                  showBookmark: true,
                );
              },
            ),
    );
  }
}
