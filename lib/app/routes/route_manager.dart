import 'package:flutter/widgets.dart';
import 'package:newsline/app/ui/screens/welcome_screen.dart';

Map<String, WidgetBuilder> buildNamedRoutes() {
  Map<String, WidgetBuilder> namedRoutes = {
    
    '/': (BuildContext context) => WelcomeScreen(),
  };

  return namedRoutes;
}
