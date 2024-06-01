import 'package:flutter/material.dart';

class News {
  final String? source;
  final List<dynamic>? authors;
  final String? title;
  final String? url;
  final String? urlToImage;
  final String? publishedTime;

  News(this.source, this.authors, this.title, this.url, this.urlToImage,
      this.publishedTime);

  factory News.fromJson(Map<String, dynamic> json) {
    return News(json['source_id'], json['creator'], json['title'], json['link'],
        json['image_url'], json['pubDate']!);
  }

  factory News.fromFavorites(Map<dynamic, dynamic> json) {
    return News(json['source'], json['authors'], json['title'], json['url'],
        json['urlToImage'], json['publishedTime']);
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source,
      'authors': authors,
      'title': title,
      'url': url,
      'urlToImage': urlToImage,
      'publishedTime': publishedTime
    };
  }

  String getAuthor() {
    if (authors == null) return "[Author not listed]";
    return "Written by ${authors![0]}${authors!.length > 1 ? " & Others" : ""}";
  }

  ImageProvider getImage() {
    if (urlToImage == null ||
        !(urlToImage!.endsWith(".jpg") || urlToImage!.endsWith(".jpeg")))
      return const AssetImage("assets/image/logo-3.png");
    try {
      return NetworkImage(
        urlToImage.toString(),
      );
    } catch (e) {
      print(e.toString());
      return const AssetImage("assets/image/logo-3.png");
    }
  }
}
