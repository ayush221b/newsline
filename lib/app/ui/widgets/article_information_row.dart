import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsline/app/models/news_article.dart';
import 'package:newsline/app/ui/widgets/bookmark_button.dart';
import 'package:share/share.dart';

class ArticleInformationRow extends StatelessWidget {
  const ArticleInformationRow({
    Key key,
    @required this.newsArticle,
  }) : super(key: key);

  final NewsArticle newsArticle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (newsArticle.author.length > 15)
            Text('${newsArticle.author?.substring(0, 15) ?? ''}')
          else
            Text('${newsArticle.author ?? ''}'),
          Text('${DateFormat.yMMMMd().format(newsArticle.publishedAt)}'),
          IconButton(
            icon: Icon(
              Icons.share,
              size: 18,
            ),
            onPressed: () {
              Share.share(
                  '${newsArticle.title}. \n ${newsArticle.url} \n Newsline - Latest News, tailored for you.');
            },
          ),
          BookmarkButton(
            newsArticle: newsArticle,
          )
        ],
      ),
    );
  }
}
