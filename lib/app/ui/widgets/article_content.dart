import 'package:flutter/material.dart';
import 'package:newsline/app/models/news_article.dart';

class ArticleContent extends StatelessWidget {
  const ArticleContent({
    Key key,
    @required this.showDescription,
    @required this.newsArticle,
  }) : super(key: key);

  final bool showDescription;
  final NewsArticle newsArticle;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${showDescription ? newsArticle.description : newsArticle.content?.substring(0, 260) ?? newsArticle.description}',
      style: TextStyle(fontSize: 16, height: 1.25),
    );
  }
}
