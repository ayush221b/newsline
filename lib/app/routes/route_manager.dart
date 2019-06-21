import 'package:flutter/widgets.dart';
import 'package:newsline/app/services/location_service.dart';
import 'package:newsline/app/services/news_service.dart';
import 'package:newsline/app/ui/screens/bookmarked_articles_screen.dart';
import 'package:newsline/app/ui/screens/loading_screen.dart';
import 'package:newsline/app/ui/screens/news_screen.dart';
import 'package:newsline/app/ui/screens/onboarding_screen.dart';

Map<String, WidgetBuilder> buildNamedRoutes(
    NewsService newsService, LocationService locationService) {
  Map<String, WidgetBuilder> namedRoutes = {
    '/news': (BuildContext context) => NewsScreen(),
    '/': (BuildContext context) => LoadingScreen(
          newsService: newsService,
          locationService: locationService,
        ),
    '/onboard': (BuildContext context) => OnboardingScreen(),
    '/bookmarks': (BuildContext context) => BookmarkedArticlesScreen(newsService: newsService),
  };

  return namedRoutes;
}
