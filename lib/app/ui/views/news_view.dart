import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:newsline/app/services/location_service.dart';
import 'package:newsline/app/services/news_service.dart';
import 'package:newsline/app/ui/screens/single_news_screen.dart';
import 'package:newsline/app/ui/views/search_view.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var newsService = Provider.of<NewsService>(context);
    var locationService = Provider.of<LocationService>(context);

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          expandedHeight: 150,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF14568C),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(50))),
              padding:
                  EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Text('Newsline'.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontFamily: 'Lora',
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 4))),
                            Row(
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                        '${DateFormat.yMMMMd().format(DateTime.now())}  |',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18))),
                                Container(
                                  padding: EdgeInsets.only(top: 5, left: 10),
                                  child: Text(
                                      '${locationService.userLocation.administrativeArea}, ${locationService.userLocation.country}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchNews(newsService: newsService));
              },
            ),
            IconButton(
                icon: Icon(Icons.collections_bookmark), onPressed: () {}),
            IconButton(icon: Icon(Icons.sort), onPressed: () {})
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(top: 32.0, left: 16, bottom: 5),
              child: Text(
                'Latest News',
                style: TextStyle(color: Color(0xFF14568C), fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 5),
              child: Text(
                'Top Stories For You',
                style: TextStyle(color: Color(0xFF14568C), fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 120),
              child: Divider(
                color: Color(0xFF14568C),
              ),
            ),
          ]),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return SingleNewsScreen(
                        newsArticle: newsService.articles[i],
                      );
                    }));
                  },
                  child: Hero(
                    tag: newsService.articles[i].url,
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
                              newsService.articles[i].urlToImage ?? '',
                            )),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          ' ${newsService.articles[i].title} ',
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
            },
            childCount: newsService.articles.length,
          ),
        )
      ],
    ));
  }
}
