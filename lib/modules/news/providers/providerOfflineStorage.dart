import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/helperSession.dart';
import '../../../helper/helperSharedPrefs.dart';
import '../models/modelNews.dart';

class ProviderOfflineStorage extends ChangeNotifier {
  ModelNews response = ModelNews(status: "", totalResults: 0, articles: null);

  ModelNews get getResponse => response;

  late SharedPreferences sharedPreferences;

  void initSharedPreferences() async {
    await SharedPreferencesHelper.init();
    sharedPreferences = SharedPreferencesHelper.instance;
    getData();
    notifyListeners();
  }

  addData(dynamic value) {
    sharedPreferences.setString(HelperSession.IHelperObject, value);
    getData();
    notifyListeners();
  }

  getData() {
    List<Article> list;

    dynamic offlineData = sharedPreferences.get(HelperSession.IHelperObject);
    dynamic data = jsonDecode(offlineData);

    if (data['articles'].isNotEmpty) {
      list = [];
      data['articles'].forEach((v) {
        list.add(Article.fromJson(v));
      });
    } else {
      list = [];
    }
    response = ModelNews(status: "ok", totalResults: 0, articles: list);
    notifyListeners();
  }
}
