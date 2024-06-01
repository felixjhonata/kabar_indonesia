import 'package:flutter/material.dart';
import 'package:news_app_v2/HomePage.dart';
import 'package:news_app_v2/PageState.dart';
import 'package:news_app_v2/module/Favorites.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends PageState<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _body() {
    Favorites.fetchFavorites();
    news = Favorites.favorites;
    
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index >= news.length) {
          return Column(
            children: [
              SizedBox(
                  height:
                      (news.length > 4 ? 20 : 140.0 * (4 - news.length) + 126)),
              footer(),
            ],
          );
        }
        return newsCard(index);
      },
      itemCount: news.length + 1,
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: const Color(0xFF14213D),
      leadingWidth: 250,
      leading: Container(
        margin: const EdgeInsets.fromLTRB(30, 70, 0, 0),
        child: const Text(
          "Favorites",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      toolbarHeight: 150,
    );
  }

  Container _bottomNavigationBar() {
    return Container(
      height: 100,
      color: const Color(0xFF14213D),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 75),
            child: GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Home",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(height: 5),
                Text(
                  "Favorites",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
