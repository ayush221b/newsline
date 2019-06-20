import 'package:flutter/material.dart';
import 'package:newsline/app/services/location_service.dart';
import 'package:newsline/app/services/news_service.dart';
import 'package:newsline/app/ui/widgets/loading_screen_widget.dart';

class LoadingView extends StatefulWidget {
  final LocationService locationService;
  final NewsService newsService;

  LoadingView({this.locationService, this.newsService});
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  String _loadingText;

  @override
  void initState() {
    traceLocationState();
    this.widget.locationService.getUserLocation();
    super.initState();
  }

  void traceLocationState() {
    if (mounted)
      this
          .widget
          .locationService
          .locationStateSubject
          .listen((LocationState locationState) {
        if (locationState == LocationState.Available) {
          traceNewsLoadState();
        } else if (locationState == LocationState.Finding) {
          setState(() {
            _loadingText = 'Getting Your Location...';
          });
        }
      });
  }

  void traceNewsLoadState() {
    if (mounted)
      this
          .widget
          .newsService
          .newsLoadState
          .listen((NewsLoadState newsLoadState) {
        if (newsLoadState == NewsLoadState.Loading) {
          setState(() {
            _loadingText = 'Fetching News Articles...';
          });
        } else if (newsLoadState == NewsLoadState.Loaded) {
          Navigator.pushReplacementNamed(context, '/news');
        }
      });

    String countryCode =
        this.widget.locationService.userLocation.isoCountryCode;
    this
        .widget
        .newsService
        .getArticlesFromDb(toRefresh: true, countryCode: countryCode);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreenWidget(
      loadingText: _loadingText,
    );
  }
}