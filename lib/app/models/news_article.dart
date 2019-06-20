import 'package:meta/meta.dart';

/// `NewsArticle` provides a representative data model class
/// which helps to parse the received json in response from NewsApi.org
/// `sourceId` : NewsApi Id(if present) of the source
/// `sourceName` : Name of Source
/// `author` : Author of article
/// `title` : Title of Article
/// `description` : Description about article
/// `url` : Url to original article
/// `urlToImage` : Link to the image, relevant to the article
/// `publishedAt` : Date and Time when the article was published in UTC(+000)
/// `content` : Content of article, truncated to 260 characters (Developer Plan Limit)
/// `category` : Category of article
class NewsArticle {
  String sourceId;
  String sourceName;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;
  String category;

  NewsArticle(
      {@required this.sourceId,
      @required this.sourceName,
      @required this.author,
      @required this.title,
      @required this.description,
      @required this.url,
      @required this.urlToImage,
      @required this.publishedAt,
      @required this.content,
      this.category});

  /// Named Constructor which receives a map [responseMap] and parses
  /// it into a [NewsArticle] instance.
  NewsArticle.fromMap(Map articleMap) {
    sourceId = articleMap['sourceId'];
    sourceName = articleMap['sourceName'];
    author = articleMap['author'];
    title = articleMap['title'];
    description = articleMap['description'];
    url = articleMap['url'];
    urlToImage = articleMap['urlToImage'];
    publishedAt = DateTime.parse(articleMap['publishedAt']);
    content = articleMap['content'];
    if (articleMap['category'] != null) category = articleMap['category'];
  }

  /// Function to generate a `Map<String, dynamic>` from a `NewsArticle` instance.
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['sourceId'] = this.sourceId;
    data['sourceName'] = this.sourceName;
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['publishedAt'] = this.publishedAt.toString();
    data['content'] = this.content;

    if (this.category != null) data['category'] = this.category;

    return data;
  }
}
