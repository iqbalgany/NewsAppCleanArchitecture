import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/config/themes/app_themes.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/pages/daily_news_view.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

void main() async {
  await initializeDepedencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: DailyNewsView(),
    );
  }
}
