import 'package:flutter/widgets.dart';
import 'package:newsline/app/models/news_article.dart';
import 'package:http/http.dart' as http;
import 'package:newsline/app/secret_key.dart';

// enum to track the progress of News Articles
enum NewsLoadState {
  Loading,
  Loaded,
  Failed
}

/// `NewsService` will act as a utility class and perform all
/// operations related to the NewsArticles.
class NewsService extends ChangeNotifier {
  List<NewsArticle> _articlesList = [];

  List<NewsArticle> get articles {
    return _articlesList;
  }

  Future getArticlesFromApi(
      {int page = 1, String country = 'in', String query = '', String category=''}) async {

    String baseUrl = 'https://newsapi.org/v2/top-headlines';

    String requestParams = '?apiKey=${SecretKey.apiKey}' 
        + '&country=$country'
        + '&page=$page'
        + '&q=$query'
        + '&category=$category';
    
    try {

      http.Response apiResponse = await http.get(baseUrl+requestParams);

      if(apiResponse.statusCode != 200) {
        // do something
      } else {
        
      }

    } catch(exception) {
      print(exception);
    } 


  }
}
