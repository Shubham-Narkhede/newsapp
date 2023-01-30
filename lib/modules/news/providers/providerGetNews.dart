import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:news_app/modules/news/models/modelNews.dart';

import '../repo/RepoGetNews.dart';

class ProviderGetNews extends ChangeNotifier {
  ModelNews response = ModelNews(status: "", totalResults: 0, articles: null);

  ModelNews get getResponse => response;

  getProductsList() {
    List<Article> list;
    RepositoryNews.instance.getNewsList().then((value) {
      final data = json.decode(value.body);

      if (data['articles'].isNotEmpty) {
        list = [];
        data['articles'].forEach((v) {
          list.add(Article.fromJson(v));
        });
      } else {
        list = [];
      }

      response =
          ModelNews(status: "ok", totalResults: list.length, articles: list);
      notifyListeners();
    }).catchError((onError) {
      response = ModelNews(status: "error", totalResults: 0, articles: null);
      notifyListeners();
    });
  }
}
