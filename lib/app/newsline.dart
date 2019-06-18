import 'package:flutter/material.dart';
import 'package:newsline/app/routes/route_manager.dart';

class NewslineApp extends StatefulWidget {
  @override
  _NewslineAppState createState() => _NewslineAppState();
}

class _NewslineAppState extends State<NewslineApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newsline',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        brightness: Brightness.light
      ),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      routes: buildNamedRoutes(),
    );
  }
}