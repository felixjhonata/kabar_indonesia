import 'package:flutter/material.dart';
import 'package:news_app_v2/PageState.dart';
import 'package:news_app_v2/model/News.dart';
import 'package:news_app_v2/module/Favorites.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsArticle extends StatefulWidget {
  final PageState<StatefulWidget> page;
  final News news;
  const NewsArticle({super.key, required this.page, required this.news});

  @override
  State<NewsArticle> createState() => _NewsArticleState();
}

class _NewsArticleState extends State<NewsArticle> {
  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.news.url!));
    return Scaffold(
      appBar: _appBar(),
      body: WebViewWidget(controller: controller),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: const Color(0xFF14213D),
      toolbarHeight: 150,
      title: const Padding(
        padding: EdgeInsets.only(top: 35),
        child: Text(
          "News Article",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(20, 70, 0, 35),
        child: IconButton(
          icon: const Icon(
            color: Colors.white,
            Icons.arrow_back_ios_new,
            size: 30,
          ),
          onPressed: () {
            widget.page.setState(() {});
            Navigator.pop(context);
          },
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 70, 30, 35),
          child: IconButton(
            onPressed: () =>
                setState(() => Favorites.toggleFavorites(widget.news)),
            icon: Icon(
              Favorites.findInFavorites(widget.news.url!)
                  ? Icons.favorite
                  : Icons.favorite_outline_rounded,
              size: 35,
              color: Favorites.findInFavorites(widget.news.url!)
                  ? const Color(0xffFCA311)
                  : const Color(0xFFFFFFFF),
            ),
          ),
        ),
      ],
    );
  }
}
