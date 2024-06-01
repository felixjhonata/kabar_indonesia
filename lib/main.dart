import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:news_app_v2/HomePage.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('favorites-list');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: const HomePage(),
    );
  }
}
