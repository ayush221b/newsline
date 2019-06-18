import 'package:flutter/widgets.dart';
import 'package:newsline/app/models/news_article.dart';

/// `NewsService` will act as a utility class and perform all
  /// operations related to the NewsArticles.
class NewsService extends ChangeNotifier{

  List<NewsArticle> _articlesList=[];

  List<NewsArticle> get articles {
    return _articlesList;
  }
}