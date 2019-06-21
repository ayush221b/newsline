import 'package:flutter/material.dart';
import 'package:newsline/app/models/news_article.dart';
import 'package:newsline/app/ui/widgets/article_content.dart';
import 'package:newsline/app/ui/widgets/article_header.dart';
import 'package:newsline/app/ui/widgets/article_information_row.dart';
import 'package:newsline/app/ui/widgets/swipe_to_article.dart';

class SingleNewsView extends StatefulWidget {
  final NewsArticle newsArticle;

  SingleNewsView({this.newsArticle});

  @override
  _SingleNewsViewState createState() => _SingleNewsViewState();
}

class _SingleNewsViewState extends State<SingleNewsView> {
  bool showDescription = false;
  NewsArticle newsArticle;

  @override
  void initState() {
    newsArticle = this.widget.newsArticle;
    if (newsArticle.content != null) {
      if (newsArticle.content.length < 260)
        setState(() {
          showDescription = true;
        });
    }
    super.initState();
  }

  Text buildTitleText() {
    return Text('${newsArticle.title}',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontFamily: 'Lora'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              ArticleHeader(
                newsArticle: newsArticle,
              ),
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  Container(
                    margin: EdgeInsets.all(12.0),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        buildTitleText(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SizedBox(
                            width: 200,
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ArticleInformationRow(newsArticle: newsArticle),
                        ArticleContent(
                            showDescription: showDescription,
                            newsArticle: newsArticle),
                        Container(
                          height: 80,
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ],
          ),
          SwipeToArticle(
            newsArticle: newsArticle,
          ),
        ],
      ),
    );
  }
}
