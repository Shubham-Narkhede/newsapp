import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/modules/news/models/modelNews.dart';
import 'package:news_app/modules/news/providers/providerOfflineStorage.dart';
import 'package:provider/provider.dart';

import '../repo/RepoGetNews.dart';

class ProviderGetNews extends ChangeNotifier {
  ModelNews response = ModelNews(status: "", totalResults: 0, articles: null);

  ModelNews get getResponse => response;

  getProductsList(BuildContext context) {
    List<Article> list;
    RepositoryNews.instance.getNewsList().then((value) async {
      if (Provider.of<ProviderOfflineStorage>(context, listen: false)
              .response
              .articles ==
          null) {
        Provider.of<ProviderOfflineStorage>(context, listen: false)
            .addData(value.body);
      }
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
