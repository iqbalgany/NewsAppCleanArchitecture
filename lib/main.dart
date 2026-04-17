import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/pages/daily_news.dart';
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
      theme: ThemeData(textTheme: GoogleFonts.mulishTextTheme()),
      home: DailyNews(),
    );
  }
}
