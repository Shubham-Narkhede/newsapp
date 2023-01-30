import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/modules/news/models/modelNews.dart';
import 'package:news_app/modules/news/providers/providerOfflineStorage.dart';
import 'package:provider/provider.dart';

import '../repo/RepoGetNews.dart';

/// this ProviderGetNews class we have created to get all the news data
class ProviderGetNews extends ChangeNotifier {
  /// first we emit the null data
  ModelNews response = ModelNews(status: "", totalResults: 0, news: null);

  ModelNews get getResponse => response;

  /// This method works like data binding method
  getProductsList(BuildContext context) {
    List<News> list;

    /// here we get response from the respository
    RepositoryNews.instance.getNewsList().then((value) async {
      print(Provider.of<ProviderOfflineStorage>(context, listen: false)
          .response
          .news);

      /// now to store data in offline storage we are check first if the shared preference
      /// data is null then we immediatly add encoded json responce in shared preference
      if (Provider.of<ProviderOfflineStorage>(context, listen: false)
              .response
              .news ==
          null) {
        Provider.of<ProviderOfflineStorage>(context, listen: false)
            .addData(value.body);
      }
      final data = json.decode(value.body);

      if (data['articles'].isNotEmpty) {
        list = [];
        data['articles'].forEach((v) {
          list.add(News.fromJson(v));
        });
      } else {
        list = [];
      }

      /// after successfully get the data we only emit the response with status
      response = ModelNews(status: "ok", totalResults: list.length, news: list);
      notifyListeners();
    }).catchError((onError) {
      response = ModelNews(status: "error", totalResults: 0, news: null);
      notifyListeners();
    });
  }
}
