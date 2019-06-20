import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:intl/intl.dart';
import 'package:newsline/app/models/news_article.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

class SingleNewsView extends StatefulWidget {
  final NewsArticle newsArticle;

  SingleNewsView({this.newsArticle});

  @override
  _SingleNewsViewState createState() => _SingleNewsViewState();
}

class _SingleNewsViewState extends State<SingleNewsView> {
  bool shouldFallback = false;
  bool showDescription = false;

  @override
  void initState() {
    checkImageLoad();

    if (this.widget.newsArticle.content != null) {
      if (this.widget.newsArticle.content.length < 260)
        setState(() {
          showDescription = true;
        });
    }
    super.initState();
  }

  void checkImageLoad() async {
    final response = await http.head(this.widget.newsArticle.urlToImage);

    if (response.statusCode != 200) {
      setState(() {
        shouldFallback = true;
      });
    }
  }

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
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
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
                    tag: widget.newsArticle.url,
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
                                        widget.newsArticle.urlToImage ?? ''))),
                          ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  Container(
                    margin: EdgeInsets.all(12.0),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('${this.widget.newsArticle.title}',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, fontFamily: 'Lora')),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SizedBox(
                            width: 200,
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('${this.widget.newsArticle.author ?? ''}'),
                              Text(
                                  '${DateFormat.yMMMMd().format(this.widget.newsArticle.publishedAt)}'),
                              IconButton(
                                icon: Icon(
                                  Icons.share,
                                  size: 18,
                                ),
                                onPressed: () {
                                  Share.share(
                                      '${this.widget.newsArticle.title}. \n ${this.widget.newsArticle.url} \n Newsline - Latest News, tailored for you.');
                                },
                              )
                            ],
                          ),
                        ),
                        Text(
                          '${showDescription ? this.widget.newsArticle.description : this.widget.newsArticle.content?.substring(0, 260) ?? this.widget.newsArticle.description}',
                          style: TextStyle(fontSize: 16, height: 1.25),
                        ),
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
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                _launchURL(context, this.widget.newsArticle.url);
              },
              onHorizontalDragStart: (_) {
                _launchURL(context, this.widget.newsArticle.url);
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
          )
        ],
      ),
    );
  }
}
