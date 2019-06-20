import 'package:flutter/material.dart';
import 'package:newsline/app/routes/route_manager.dart';
import 'package:newsline/app/services/location_service.dart';
import 'package:newsline/app/services/news_service.dart';
import 'package:provider/provider.dart';

class NewslineApp extends StatefulWidget {
  @override
  _NewslineAppState createState() => _NewslineAppState();
}

class _NewslineAppState extends State<NewslineApp> {
  NewsService _newsService;
  LocationService _locationService;
  bool onboard = false;

  @override
  void initState() {
    _newsService = NewsService();
    _locationService = LocationService();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider<NewsService>(
          builder: (_) => _newsService,
        ),
        ChangeNotifierProvider<LocationService>(
          builder: (_) => _locationService,
        )
      ],
      child: MaterialApp(
        title: 'Newsline',
        theme: ThemeData(
            primaryColor: Color(0xFF14568C), brightness: Brightness.light),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: buildNamedRoutes(_newsService, _locationService),
      ),
    );
  }
}
