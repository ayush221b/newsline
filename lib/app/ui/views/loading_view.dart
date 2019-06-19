import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsline/app/services/location_service.dart';
import 'package:newsline/app/services/news_service.dart';

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
          Navigator.pushNamed(context, '/');
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

class LoadingScreenWidget extends StatelessWidget {
  final String loadingText;

  LoadingScreenWidget({this.loadingText = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(12.0),
            padding: EdgeInsets.all(8),
            child: Text(
              'Newsline',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                  letterSpacing: 5),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(12.0),
            padding: EdgeInsets.all(8),
            child: SvgPicture.asset(
              'assets/image/news.svg',
              width: 300,
            ),
          ),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(12.0),
              padding: EdgeInsets.all(8),
              child: Text(
                '$loadingText',
                style: TextStyle(fontSize: 18),
              )),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(12.0),
              padding: EdgeInsets.all(8),
              child: SizedBox(
                  height: 2.0,
                  width: 200,
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ))),
        ],
      ),
    );
  }
}
