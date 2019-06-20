import 'package:flutter/material.dart';
import 'package:newsline/app/ui/widgets/onboarding_template.dart';

class OnboardingView extends StatefulWidget {
  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          OnboardingTemplate(
            controller: _controller,
            imagePath: 'assets/image/welcome.svg',
            text:
                'Hello, welcome to Newsline. \n\nSee what\'s making headlines near you, right here, right now.',
          ),
          OnboardingTemplate(
            controller: _controller,
            imagePath: 'assets/image/search.svg',
            text: 'Search through news, and find what interests you.',
          ),
          OnboardingTemplate(
            controller: _controller,
            imagePath: 'assets/image/share.svg',
            text: 'Share the articles with your friends.',
          ),
          OnboardingTemplate(
            controller: _controller,
            imagePath: 'assets/image/click-here.svg',
            text: 'Quickly jump to original article, right inside the app.',
          ),
        ],
      ),
    );
  }
}

