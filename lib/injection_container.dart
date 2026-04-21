import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecase/get_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubits/article/remote/remote_article_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDepedencies() async {
  final database = await $FloorAppDatabase
      .databaseBuilder('app_database.db')
      .build();

  sl.registerSingleton<AppDatabase>(database);

  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl()));

  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  sl.registerSingleton<RemoteArticleCubit>(
    RemoteArticleCubit(getArticleUseCase: sl()),
  );
}
