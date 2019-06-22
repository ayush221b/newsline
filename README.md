# Newsline



Newsline is an android application made with flutter which makes use of [NewsAPI.org](http://newsapi.org/) to fetch and serve the latest and trending news as per the user's location. The location is taken in realtime and not stored anywhere except the user's device.

## Flow of Application

On App Launch:

1. Get User's location
2. Geocode the coordinates to get location details
3. Pass the country code to get relevant news
4. Fetch and Store the news artciles to offline database.
5. If its the first launch, redirect to onboarding flow, to highlight major features, then proceed to 6.
6. Main screen of the application, displaying the master list of news articles.
7. Clicking on a card redirects to the details of the article.

## Major Features

1. News always relevant based on location
2. Offline availability of articles
3. Share articles across apps
4. Jump to article on the web
5. Bookmark articles for reading later
6. Pull to refresh wherever articles are listed

## Getting Started with Flutter

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
