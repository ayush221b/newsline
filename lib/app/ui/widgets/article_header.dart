import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsline/app/models/news_article.dart';
import 'package:http/http.dart' as http;

class ArticleHeader extends StatefulWidget {
  final NewsArticle newsArticle;

  ArticleHeader({this.newsArticle});
  @override
  _ArticleHeaderState createState() => _ArticleHeaderState();
}

class _ArticleHeaderState extends State<ArticleHeader> {
  NewsArticle _newsArticle;
  bool shouldFallback = false;

  @override
  void initState() {
    _newsArticle = this.widget.newsArticle;
    checkImageLoad();
    super.initState();
  }

  void checkImageLoad() async {
    try {
      final response = await http.head(this.widget.newsArticle.urlToImage);

      if (response.statusCode != 200) {
        setState(() {
          shouldFallback = true;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        shouldFallback = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      expandedHeight: 300,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: shouldFallback ? Colors.white : Colors.indigoAccent,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: _newsArticle.url,
          child: shouldFallback
              ? Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                  child: Text(
                    'NEWSLINE',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              _newsArticle.urlToImage ?? ''))),
                ),
        ),
      ),
    );
  }
}
