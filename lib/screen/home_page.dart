import 'package:flutter/material.dart';
import 'package:news_app/tile/artical_tile.dart';
import 'package:provider/provider.dart';
import 'package:news_app/provider/news_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      Provider.of<NewsProvider>(context, listen: false).searchArticles(query);
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch default news
    Provider.of<NewsProvider>(context, listen: false).fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 145, 227),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onSubmitted: _performSearch,
              decoration: InputDecoration(
                hintText: 'Search news...',
                prefixIcon: const Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    Provider.of<NewsProvider>(
                      context,
                      listen: false,
                    ).fetchArticles(); // Load default news
                  },
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Builder(
        builder: (_) {
          if (newsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (newsProvider.error != null) {
            return Center(child: Text("Error: ${newsProvider.error!}"));
          }

          if (newsProvider.articles.isEmpty) {
            return const Center(child: Text("No news available."));
          }

          return RefreshIndicator(
            onRefresh: () => newsProvider.fetchArticles(),
            child: ListView.builder(
              itemCount: newsProvider.articles.length,
              itemBuilder: (context, index) {
                return NewsArticleTile(
                  article: newsProvider.articles[index],
                  showBookmark: true,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
