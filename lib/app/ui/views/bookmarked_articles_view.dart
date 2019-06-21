import 'package:flutter/material.dart';
import 'package:newsline/app/models/news_article.dart';
import 'package:newsline/app/services/news_service.dart';
import 'package:newsline/app/ui/widgets/news_article_card.dart';
import 'package:provider/provider.dart';

class BookmarkedArticlesView extends StatefulWidget {
  final NewsService newsService;

  const BookmarkedArticlesView({Key key, this.newsService}) : super(key: key);

  @override
  _BookmarkedArticlesViewState createState() => _BookmarkedArticlesViewState();
}

class _BookmarkedArticlesViewState extends State<BookmarkedArticlesView> {
  bool _isLoading = false;

  @override
  void initState() {
    getArticles();
    super.initState();
  }

  void getArticles() async {
    setState(() {
      _isLoading = true;
    });

    await this.widget.newsService.getBookmarkedArticles();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<NewsArticle> articles = [];
    var newsService = Provider.of<NewsService>(context);
    articles = newsService.bookmarks;
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarked Articles'),
        automaticallyImplyLeading: true,
      ),
      body: _isLoading
          ? Center(
              child: Text('Loading Articles...'),
            )
          : articles.length == 0
              ? Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'You have not bookmarked any articles. \nPlease consider bookmarking some.',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (BuildContext context, int index) {
                    NewsArticle article = articles[index];
                    return Dismissible(
                      background: Container(
                        color: Colors.red,
                      ),
                      onDismissed: (_) async {
                        await newsService.updateArticleBookmark(
                            url: article.url, toBookmark: false);
                            articles.remove(article);
                      },
                      child: NewsArticleCard(
                        article: article,
                      ),
                      key: Key('${article.url}'),
                    );
                  },
                ),
    );
  }
}
