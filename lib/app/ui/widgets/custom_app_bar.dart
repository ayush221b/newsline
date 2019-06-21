import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsline/app/services/location_service.dart';
import 'package:newsline/app/services/news_service.dart';
import 'package:newsline/app/ui/views/search_view.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
    @required this.locationService,
    @required this.newsService,
  }) : super(key: key);

  final LocationService locationService;
  final NewsService newsService;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
          padding: EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
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
                                        color: Colors.white, fontSize: 18))),
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
        IconButton(icon: Icon(Icons.collections_bookmark), onPressed: () {
          Navigator.of(context).pushNamed('/bookmarks');
        }),
        
      ],
    );
  }
}
