import 'package:flutter/material.dart';
import 'package:newsline/app/models/news_article.dart';
import 'package:newsline/app/services/news_service.dart';
import 'package:provider/provider.dart';

class BookmarkButton extends StatefulWidget {
  final NewsArticle newsArticle;

  BookmarkButton({this.newsArticle});
  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  NewsArticle newsArticle;

  @override
  void initState() {
    newsArticle = this.widget.newsArticle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var newsService = Provider.of<NewsService>(context);
    return IconButton(
      icon: Icon(
        newsArticle.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        color: Colors.red,
        size: 20,
      ),
      onPressed: () async {
        if (newsArticle.isBookmarked) {
          await newsService.updateArticleBookmark(
              toBookmark: false, url: newsArticle.url);
        } else {
          await newsService.updateArticleBookmark(
              toBookmark: true, url: newsArticle.url);
        }

        NewsArticle article =
            await newsService.getSingleArticle(newsArticle.url);

        setState(() {
          newsArticle = article;
        });
      },
    );
  }
}
