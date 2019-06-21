import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:newsline/app/models/news_article.dart';

class SwipeToArticle extends StatelessWidget {
  final NewsArticle newsArticle;

  SwipeToArticle({this.newsArticle});

  void _launchURL(BuildContext context, String url) async {
    try {
      await launch(
        '$url',
        option: new CustomTabsOption(
            toolbarColor: Theme.of(context).primaryColor,
            enableDefaultShare: true,
            enableUrlBarHiding: true,
            showPageTitle: true,
            animation: new CustomTabsAnimation.slideIn()),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: GestureDetector(
        onTap: () {
          _launchURL(context, newsArticle.url);
        },
        onHorizontalDragStart: (_) {
          _launchURL(context, newsArticle.url);
        },
        child: Container(
          color: Colors.indigo,
          padding: EdgeInsets.all(8),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Go to Article',
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.arrow_right,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
