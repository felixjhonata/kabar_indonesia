import 'package:flutter/material.dart';
import 'package:news_app_v2/FavoritesPage.dart';
import 'package:news_app_v2/PageState.dart';
import 'package:news_app_v2/SearchPage.dart';
import 'package:news_app_v2/module/NewsFetcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  FutureBuilder<dynamic> _body() {
    return FutureBuilder(
      future: NewsFetcher.fetchNews(news, "id"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index >= news.length) {
                return Column(
                  children: [
                    SizedBox(
                        height: (news.length > 4
                            ? 20
                            : 140.0 * (4 - news.length) + 126)),
                    footer(),
                  ],
                );
              }
              return newsCard(index);
            },
            itemCount: news.length + 1,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: const Color(0xFF14213D),
      leadingWidth: 250,
      leading: Container(
        margin: const EdgeInsets.fromLTRB(5, 70, 30, 25),
        child: Image.asset(
          "assets/image/logo-1.png",
        ),
      ),
      toolbarHeight: 150,
      actions: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 60, 40, 30),
          child: IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 40,
            ),
            alignment: Alignment.centerLeft,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(home: this),
                )),
          ),
        ),
      ],
    );
  }

  Container _bottomNavigationBar() {
    return Container(
      height: 100,
      color: const Color(0xFF14213D),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 75),
            child: Column(
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
          Padding(
            padding: const EdgeInsets.only(left: 75),
            child: GestureDetector(
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FavoritesPage()),),
              child: const Column(
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
          ),
        ],
      ),
    );
  }
}
