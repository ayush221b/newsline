import 'package:flutter/widgets.dart';
import 'package:newsline/app/services/location_service.dart';
import 'package:newsline/app/services/news_service.dart';
import 'package:newsline/app/ui/screens/loading_screen.dart';
import 'package:newsline/app/ui/screens/news_screen.dart';

Map<String, WidgetBuilder> buildNamedRoutes(
    NewsService newsService, LocationService locationService) {
  Map<String, WidgetBuilder> namedRoutes = {
    '/': (BuildContext context) => NewsScreen(),
    '/loading': (BuildContext context) => LoadingScreen(
          newsService: newsService,
          locationService: locationService,
        )
  };

  return namedRoutes;
}
