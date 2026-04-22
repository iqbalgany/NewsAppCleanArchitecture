import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/remove_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/save_article.dart';

part 'local_article_state.dart';

class LocalArticleCubit extends Cubit<LocalArticleState> {
  final GetSavedArticleUseCase getSavedArticleUseCase;
  final SaveArticleUseCase saveArticleUseCase;
  final RemoveArticleUseCase removeArticleUseCase;

  LocalArticleCubit({
    required this.getSavedArticleUseCase,
    required this.saveArticleUseCase,
    required this.removeArticleUseCase,
  }) : super(LocalArticleLoading()) {
    onGetSavedArticles();
  }

  void onGetSavedArticles() async {
    final articles = await getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }

  void onFavoriteToggle(ArticleEntity article, bool isSaved) async {
    if (isSaved) {
      await removeArticleUseCase(params: article);
    } else {
      await saveArticleUseCase(params: article);
    }

    onGetSavedArticles();
  }
}
