import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubits/article/remote/remote_article_cubit.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/pages/daily_news_page.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

class DailyNewsView extends StatelessWidget {
  const DailyNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RemoteArticleCubit(getArticleUseCase: sl()),
      child: DailyNewsPage(),
    );
  }
}
