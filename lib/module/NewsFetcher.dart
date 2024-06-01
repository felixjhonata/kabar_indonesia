import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:news_app_v2/model/News.dart';
import 'package:news_app_v2/model/apiKey.dart';

class NewsFetcher {
  static Future fetchNews(List<dynamic> array, String country) async {
    array.clear();
    const apiKey = APIkey.newsDataKey;

    final url = Uri.parse(
      'https://newsdata.io/api/1/news?apikey=$apiKey&country=$country',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      for (var json in data['results']) {
        array.add(News.fromJson(json));
      }
    } else {
      throw Exception('Failed to fetch articles');
    }
  }

  static Future fetchNewsByQuery(List<dynamic> array, String query) async {
    array.clear();
    const apiKey = APIkey.newsDataKey;

    final url = Uri.parse(
      'https://newsdata.io/api/1/news?apikey=$apiKey&qInTitle="${query}"',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      for (var json in data['results']) {
        array.add(News.fromJson(json));
      }
    } else {
      throw Exception('Failed to fetch articles');
    }
  }
}
