import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecase/get_article.dart';

part 'remote_article_state.dart';

class RemoteArticleCubit extends Cubit<RemoteArticleState> {
  final GetArticleUseCase getArticleUseCase;

  RemoteArticleCubit({required this.getArticleUseCase})
    : super(const RemoteArticlesLoading()) {
    getArticles();
  }

  void getArticles() async {
    final dataState = await getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteArticlesError(dataState.error!));
    }
  }
}
