import 'package:hive/hive.dart';
import 'package:news_app_v2/model/News.dart';

class Favorites {
  static Box box = Hive.box('favorites-list');
  static List<News> favorites = [];

  static void fetchFavorites() {
    if (box.get('favorites') == null) {
      print("favorites is null");
      return;
    }
    favorites.clear();
    box
        .get('favorites')
        .map((json) => News.fromFavorites(json))
        .toList()
        .forEach((news) => favorites.add(news));
  }

  static bool findInFavorites(String link) {
    fetchFavorites();
    for (int i = 0; i < favorites.length; i++) {
      if (favorites[i].url == link) {
        return true;
      }
    }
    return false;
  }

  static void toggleFavorites(News news) {
    if (findInFavorites(news.url!)) {
      removeFromFavorites(news.url!);
    } else {
      addToFavorites(news);
    }
  }

  static Future<void> addToFavorites(News news) async {
    if (box.get('favorites') == null) {
      await box.put('favorites', [news.toJson()]);
    } else {
      box.get('favorites').add(news.toJson());
    }
  }

  static Future<void> removeFromFavorites(String link) async {
    for (int i = 0; i < favorites.length; i++) {
      if (favorites[i].url! == link) {
        favorites.removeAt(i);
        break;
      }
    }
    await box.put(
        'favorites', favorites.map((element) => element.toJson()).toList());
  }
}
