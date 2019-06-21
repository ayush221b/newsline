import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsline/app/models/news_article.dart';
import 'package:newsline/app/ui/screens/single_news_screen.dart';
class NewsArticleCard extends StatelessWidget {
  const NewsArticleCard({
    Key key,
    @required this.article,
  }) : super(key: key);

  final NewsArticle article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return SingleNewsScreen(
              newsArticle: article,
            );
          }));
        },
        child: Hero(
          tag: article.url,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 220,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    offset: Offset(5, 5))
              ],
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    article.urlToImage ?? '',
                  )),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                ' ${article.title} ',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )
                    ],
                    backgroundColor: Colors.black45),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
