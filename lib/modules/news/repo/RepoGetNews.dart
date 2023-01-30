import 'package:http/http.dart' as http;

class RepositoryNews {
  RepositoryNews._();
  static final _instance = RepositoryNews._();
  static RepositoryNews get instance => _instance;

  Future<dynamic> getNewsList() async {
    return await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=apple&from=2023-01-29&to=2023-01-29&sortBy=popularity&apiKey=de13c6683cb542ac9674d05de285b837"));
  }
}
