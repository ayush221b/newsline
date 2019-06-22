import 'package:flutter/material.dart';
import 'package:newsline/app/models/news_article.dart';
import 'package:newsline/app/services/location_service.dart';
import 'package:newsline/app/services/news_service.dart';
import 'package:newsline/app/ui/widgets/custom_app_bar.dart';
import 'package:newsline/app/ui/widgets/news_article_card.dart';
import 'package:provider/provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class NewsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var newsService = Provider.of<NewsService>(context);
    var locationService = Provider.of<LocationService>(context);

    return Scaffold(
        body: LiquidPullToRefresh(
          showChildOpacityTransition: false,
          backgroundColor: Theme.of(context).primaryColor,
      child: CustomScrollView(
        slivers: <Widget>[
          CustomAppBar(
              locationService: locationService, newsService: newsService),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(top: 32.0, left: 16, bottom: 5),
                child: Text(
                  'Latest News',
                  style: TextStyle(color: Color(0xFF14568C), fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 5),
                child: Text(
                  'Top Stories For You',
                  style: TextStyle(color: Color(0xFF14568C), fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 120),
                child: Divider(
                  color: Color(0xFF14568C),
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                NewsArticle article = newsService.articles[i];
                return NewsArticleCard(article: article);
              },
              childCount: newsService.articles.length,
            ),
          )
        ],
      ),
      onRefresh: () async {
        await newsService.getArticlesFromDb(
            toRefresh: true,
            countryCode: locationService.userLocation.isoCountryCode);
      },
    ));
  }
}
