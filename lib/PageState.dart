import 'package:flutter/material.dart';
import 'package:news_app_v2/NewsArticle.dart';
import 'package:news_app_v2/model/News.dart';
import 'package:news_app_v2/module/Favorites.dart';

abstract class PageState<T extends StatefulWidget> extends State<T> {
  List<News> news = [];

  GestureDetector newsCard(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NewsArticle(page: this, news: news[index]),
          ),
        );
      },
      child: Stack(
        children: [
          _newsInfo(index),
          Positioned(
            bottom: 4,
            right: 30,
            child: IconButton(
              onPressed: () =>
                  setState(() => Favorites.toggleFavorites(news[index])),
              icon: Icon(
                Favorites.findInFavorites(news[index].url!)
                    ? Icons.favorite
                    : Icons.favorite_outline_rounded,
                size: 30,
                color: Favorites.findInFavorites(news[index].url!)
                    ? const Color(0xffFCA311)
                    : const Color(0xFFFFFFFF),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _newsInfo(int index) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff44567D),
      ),
      child: Row(
        children: [
          _newsImage(index),
          _newsDetails(index),
        ],
      ),
    );
  }

  Column _newsDetails(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 1),
          alignment: Alignment.bottomLeft,
          width: 200,
          child: Text(
            news[index].title!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(15, 1, 15, 0),
          alignment: Alignment.topLeft,
          width: 180,
          child: Text(
            news[index].getAuthor(),
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 9,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Container _newsImage(int index) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: news[index].getImage(),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      width: 100,
      height: 100,
    );
  }

  Widget footer() {
    return Container(
      color: const Color(0xff14213D),
      alignment: Alignment.center,
      height: 30,
      child: const Text(
          "Copyright 2023 PT. Kabar Indonesia. All Rights Reserved.",
          style: TextStyle(color: Colors.white, fontSize: 10)),
    );
  }
}
