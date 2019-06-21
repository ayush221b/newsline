import 'dart:async';
import 'dart:io' as io;
import 'package:newsline/app/models/news_article.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

/// The [DBHelper] class serves as a database utility to interact
/// with the on device sqlite database and perform CRUD operations.
class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  /// Initialize Database in the device
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "news.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  /// Execute when first instance of the [DBHelper] class is created.
  /// It further checks if the table is present or not, if not present,
  /// then the table will be created.
  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE ARTICLES(" +
        "id INTEGER PRIMARY KEY," +
        "sourceId TEXT, sourceName TEXT," +
        "author TEXT, title TEXT," +
        "description TEXT, url TEXT," +
        "urlToImage TEXT, publishedAt TEXT," +
        "content TEXT, isBookmarked TEXT )");
    print("Created ARTICLES table");
  }

  /// Save Single article to database
  Future saveArticle(
    Map<String, dynamic> articleMap,
  ) async {
    try {
      var dbClient = await db;
      await dbClient.transaction((txn) async {
        return await txn.insert('ARTICLES', articleMap);
      });
      print('Added article');
    } catch (e) {
      print(e);
    }
  }

  /// Check if an article is already present in the database,
  /// by passing the url.
  Future<bool> findMatchingArticle(
    String url,
  ) async {
    var dbclient = await db;

    List<Map> list;
    try {
      list = await dbclient.query('ARTICLES', where: 'url=\'$url\'', limit: 1);
    } catch (e) {
      print('Error is : ' + e.toString());
    }
    if (list != null && list.length == 1) {
      return true;
    } else {
      return false;
    }
  }

  /// Fetch and Return a Single article from the Database, by passing the url.
  Future<NewsArticle> getSingleArticle(String url) async {
    var dbClient = await db;
    List<Map> articleList =
        await dbClient.query('ARTICLES', where: 'url=\'$url\'', limit: 1);
    return NewsArticle.fromMap(articleList[0]);
  }

  /// Fetch and Return the List of all articles stored in the Database
  Future<List<NewsArticle>> getArticles() async {
    var dbClient = await db;
    List<Map> resultsList = await dbClient.rawQuery('SELECT * FROM ARTICLES');
    List<NewsArticle> articles = new List();
    for (int i = 0; i < resultsList.length; i++) {
      articles.add(NewsArticle.fromMap(resultsList[i]));
    }
    return articles;
  }

  /// Update bookmark state in db
  Future updateBookmarkState({bool toBookmark = true, String url}) async {
    var dbClient = await db;
    await dbClient.update('ARTICLES', {'isBookmarked': toBookmark.toString()},
        where: 'url=\'$url\'');
  }

  /// Get bookmarks from db
  Future<List<NewsArticle>> getBookmarkedArticles() async {
    var dbClient = await db;
    List<Map> resultsList =
        await dbClient.query('ARTICLES', where: 'isBookmarked=\'true\'');
    List<NewsArticle> bookmarkedArticles = new List();
    for (int i = 0; i < resultsList.length; i++) {
      bookmarkedArticles.add(NewsArticle.fromMap(resultsList[i]));
    }
    return bookmarkedArticles;
  }

  /// Truncate table which contains the articles.
  /// This option will come in handy when refreshing articles in database.
  Future truncateTable() async {
    var dbClient = await db;
    await dbClient.delete('ARTICLES', where: 'isBookmarked=\'false\'');
  }
}
