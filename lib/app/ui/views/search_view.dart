import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsline/app/models/news_article.dart';
import 'package:newsline/app/services/news_service.dart';

class SearchNews extends SearchDelegate<String> {
  final NewsService newsService;

  SearchNews({this.newsService});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<NewsArticle> suggestionsList = [];

    if (query.isEmpty || query.length < 3)
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Text(
          'Please enter atleast 3 characters to search.',
          style: TextStyle(fontSize: 16),
        )),
      );
    else {
      suggestionsList = List.from(newsService.articles.where((article) {
        if (article.title.toLowerCase().contains(query.toLowerCase())) {
          print(article.title);
          return true;
        } else
          return false;
      }));

      return ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: suggestionsList.length,
        itemBuilder: (BuildContext context, int index) {
          NewsArticle article = suggestionsList[index];
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(width: 200, child: Text('${article.title}', style: TextStyle(fontSize: 18, fontFamily: 'Lora'),)),
                    CachedNetworkImage(
                      width: 100,
                      imageUrl: article.urlToImage ?? '',
                    )
                  ],
                ),
              ),
              Container(
                child: Divider(
                  color: Colors.black54,
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
