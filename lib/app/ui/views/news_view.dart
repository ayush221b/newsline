import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:newsline/app/services/location_service.dart';
import 'package:newsline/app/services/news_service.dart';
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
          expandedHeight: 250,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                  color: Color(0x55b5ccf2),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(50))),
              padding:
                  EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.sort,
                            size: 28,
                            color: Color(0xFF14568C),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                child: Text('Newsline',
                                    style: TextStyle(
                                        color: Color(0xFF14568C),
                                        fontSize: 26))),
                            Container(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                    '${DateFormat.yMMMMd().format(DateTime.now())}',
                                    style: TextStyle(
                                        color: Color(0xFF14568C),
                                        fontSize: 18))),
                            Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.location_on,
                                        color: Color(0xFF14568C)),
                                    Text(
                                        '${locationService.userLocation.administrativeArea}, ${locationService.userLocation.country}',
                                        style: TextStyle(
                                            color: Color(0xFF14568C),
                                            fontSize: 18)),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.white70,
                          hintText: 'Search for news',
                          suffixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16, bottom: 5),
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
              );
            },
            childCount: newsService.articles.length,
          ),
        )
      ],
    ));
  }
}
