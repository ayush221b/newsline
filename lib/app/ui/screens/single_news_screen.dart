import 'package:flutter/material.dart';
import 'package:newsline/app/models/news_article.dart';
import 'package:newsline/app/ui/views/single_news_view.dart';

class SingleNewsScreen extends StatelessWidget {
  final NewsArticle newsArticle;

  SingleNewsScreen({this.newsArticle});
  @override
  Widget build(BuildContext context) {
    return SingleNewsView(newsArticle: newsArticle);
  }
}
