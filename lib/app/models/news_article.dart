import 'package:meta/meta.dart';

class NewsArticle {

  /// `NewsArticle` provides a representative data model class
  /// which helps to parse the received json in response from NewsApi.org
  /// `source` : Map containing id(optional) and name of Source
  /// `author` : Author of article
  /// `title` : Title of Article
  /// `description` : Description about article
  /// `url` : Url to original article
  /// `urlToImage` : Link to the image, relevant to the article
  /// `publishedAt` : Date and Time when the article was published in UTC(+000)
  /// `content` : Content of article, truncated to 260 characters (Developer Plan Limit)

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

  /// Named Constructor which receives a map [responseMap] and parses
  /// it into a [NewsArticle] instance.
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

  /// Function to generate a `Map<String, dynamic>` from a `NewsArticle` instance. 
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