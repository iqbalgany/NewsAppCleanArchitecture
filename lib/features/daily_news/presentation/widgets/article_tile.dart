import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubits/article/local/local_article_cubit.dart';

class ArticleTile extends StatelessWidget {
  final ArticleEntity? article;
  const ArticleTile(this.article, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      height: MediaQuery.sizeOf(context).width / 2.2,
      child: Row(children: [_buildImage(context), _buildTitleAndDecription()]),
    );
  }

  CachedNetworkImage _buildImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: article?.urlToImage ?? '',
      imageBuilder: (context, imageProvider) => Padding(
        padding: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.sizeOf(context).width / 3,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.08),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, progress) => Padding(
        padding: EdgeInsets.all(14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.sizeOf(context).width / 3,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.08),
            ),
            child: CupertinoActivityIndicator(),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Padding(
        padding: EdgeInsets.all(14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.sizeOf(context).width / 3,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.08),
            ),
            child: Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  Expanded _buildTitleAndDecription() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article!.title ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),

            Row(
              children: [
                Icon(Icons.timeline_outlined, size: 16),
                SizedBox(width: 4),
                Text(
                  DateFormat('EEEE, d MMMM yyyy').format(article!.publishedAt!),
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),

            BlocBuilder<LocalArticleCubit, LocalArticleState>(
              builder: (context, state) {
                if (state is LocalArticleDone) {
                  final isSaved = state.articles!.any(
                    (element) => element.url == article!.url,
                  );

                  return Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () {
                        context.read<LocalArticleCubit>().onFavoriteToggle(
                          article!,
                          isSaved,
                        );
                      },
                      icon: Icon(
                        isSaved
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: Colors.red,
                      ),
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
