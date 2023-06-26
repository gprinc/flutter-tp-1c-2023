import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cells/cards.dart';
import '../models/newsList.dart';

class NewsTab extends StatelessWidget {
  const NewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsList>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, right: 16.0, left: 16.0),
      child: ListView.builder(
        itemCount: newsProvider.news.length,
        itemBuilder: (BuildContext context, int index) {
          final news = newsProvider.news[index];
          return Column(
            children: [
              NewsCard(
                  index: index,
                  title: news.title,
                  header: news.header,
                  description: news.description,
                  imageName: news.imageName),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}
