import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:newsline/app/models/news_article.dart';

import 'package:newsline/app/newsline.dart';
import 'package:newsline/app/services/location_service.dart';
import 'package:newsline/app/services/news_service.dart';

void main() async {
  final int helloNotificationId = 0;
  await AndroidAlarmManager.initialize();

  runApp(NewslineApp());

  await AndroidAlarmManager.periodic(
      const Duration(hours: 1), helloNotificationId, checkSendNotification);
}

void checkSendNotification() async {
  NewsService newsService = NewsService();
  LocationService locationService = LocationService();
  await locationService.getUserLocation();
  if (locationService.userLocation != null)
    await newsService.getArticlesFromDb(
        toRefresh: true,
        countryCode: locationService.userLocation.isoCountryCode);
  else
    await newsService.getArticlesFromDb(
      toRefresh: true,
    );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('ic_launcher');

  var initializationSettings =
      new InitializationSettings(initializationSettingsAndroid, null);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (_) {});
  NewsArticle article = newsService.articles[0];
  if (article != null) {
    var bigTextStyleInformation = BigTextStyleInformation(
        '${article.description ?? ''}',
        htmlFormatBigText: true,
        contentTitle: '${article.title}',
        htmlFormatContentTitle: true,
        summaryText: 'Trending Now',
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'id_001', 'Newsline Daily', 'Get daily trends',
        style: AndroidNotificationStyle.BigText,
        styleInformation: bigTextStyleInformation);
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, null);

    await flutterLocalNotificationsPlugin.show(
        0, '${article.title}', '', platformChannelSpecifics);
  }
}