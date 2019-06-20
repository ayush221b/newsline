import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingTemplate extends StatelessWidget {
  const OnboardingTemplate({
    Key key,
    @required PageController controller,
    @required String imagePath,
    @required String text,
  })  : _controller = controller,
        _imagePath = imagePath,
        _text = text,
        super(key: key);

  final PageController _controller;
  final String _imagePath;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              '$_imagePath',
              width: 200,
            ),
            Text(
              '$_text',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 24),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (_imagePath == 'assets/image/welcome.svg')
                  FlatButton.icon(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/news');
                    },
                    label: Text('Skip'),
                    icon: Icon(Icons.fast_forward),
                  )
                else
                  FlatButton.icon(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      _controller.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                    label: Text('Previous'),
                    icon: Icon(Icons.navigate_before),
                  ),
                if (_imagePath == 'assets/image/click-here.svg')
                  FlatButton.icon(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/news');
                    },
                    label: Text('Continue to App'),
                    icon: Icon(Icons.navigate_next),
                  )
                else
                  FlatButton.icon(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                    label: Text('Next'),
                    icon: Icon(Icons.navigate_next),
                  )
              ],
            )
          ],
        ));
  }
}
