import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/helperSession.dart';
import '../../../helper/helperSharedPrefs.dart';
import '../models/modelNews.dart';

// ProviderOfflineStorage this class is created to get the data when there is not internet connection available
class ProviderOfflineStorage extends ChangeNotifier {
  ModelNews response = ModelNews(status: "", totalResults: 0, news: null);

  ModelNews get getResponse => response;

  late SharedPreferences sharedPreferences;

  /// first we simple init the share preference
  void initSharedPreferences() async {
    await SharedPreferencesHelper.init();
    sharedPreferences = SharedPreferencesHelper.instance;
    //. once we initialize we immediatly call the get data method which return the data
    getData();
    notifyListeners();
  }

  /// this method is created to add data in shared preference
  addData(dynamic value) {
    sharedPreferences.setString(HelperSession.IHelperObject, value);
    getData();
    notifyListeners();
  }

  /// this method is used to get the offline storage data
  getData() {
    List<News>? list;

    dynamic data;
    dynamic offlineData = sharedPreferences.get(HelperSession.IHelperObject);
    if (offlineData != null) {
      data = jsonDecode(offlineData);

      if (data['articles'].isNotEmpty) {
        list = [];
        data['articles'].forEach((v) {
          list!.add(News.fromJson(v));
        });
      } else {
        list = [];
      }
    }

    response = ModelNews(
        status: "ok", totalResults: 0, news: offlineData == null ? [] : list);
    notifyListeners();
  }
}
