import 'package:meta/meta.dart';

class NewsArticle {

  Map<String, String> source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  NewsArticle({
    @required this.source,
    @required this.author,
    @required this.title,
    @required this.description,
    @required this.url,
    @required this.urlToImage,
    @required this.publishedAt,
    @required this.content
  });

  NewsArticle.fromMap(Map<String, dynamic> responseMap) {

    source = responseMap['source'];
    author = responseMap['author'];
    title = responseMap['title'];
    description = responseMap['description'];
    url = responseMap['url'];
    urlToImage = responseMap['urlToImage'];
    publishedAt = DateTime.parse(responseMap['publishedAt']);
    content = responseMap['content'];
  }

  Map<String, dynamic> toMap() {

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['source'] = this.source;
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['publishedAt'] = this.publishedAt.toString();
    data['content'] = this.content;

    return data;
  }
}