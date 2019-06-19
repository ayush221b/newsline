import 'package:flutter/material.dart';
import 'package:newsline/app/services/location_service.dart';
import 'package:newsline/app/services/news_service.dart';
import 'package:newsline/app/ui/views/loading_view.dart';

class LoadingScreen extends StatelessWidget {
  final NewsService newsService;
  final LocationService locationService;

  LoadingScreen({this.locationService, this.newsService});

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      newsService: newsService,
      locationService: locationService,
    );
  }
}
