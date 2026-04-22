import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubits/article/remote/remote_article_cubit.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/widgets/article_tile.dart';

class DailyNewsPage extends StatelessWidget {
  const DailyNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppbar(), body: _buildBody());
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text('Daily News', style: GoogleFonts.mulish(color: Colors.black)),
    );
  }

  BlocBuilder<RemoteArticleCubit, RemoteArticleState> _buildBody() {
    return BlocBuilder<RemoteArticleCubit, RemoteArticleState>(
      builder: (context, articleState) {
        if (articleState is RemoteArticlesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (articleState is RemoteArticlesError) {
          return Center(child: Icon(Icons.refresh));
        }

        if (articleState is RemoteArticlesDone) {
          return ListView.separated(
            itemCount: articleState.articles!.length,
            separatorBuilder: (context, index) => SizedBox(height: 5),
            itemBuilder: (context, index) {
              final article = articleState.articles![index];
              return ArticleTile(article);
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
