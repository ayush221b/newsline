import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
