import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/remove_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/save_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubits/article/local/local_article_cubit.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubits/article/remote/remote_article_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDepedencies() async {
  final database = await $FloorAppDatabase
      .databaseBuilder('app_database.db')
      .build();

  sl.registerSingleton<AppDatabase>(database);

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Depedencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

  // UseCases
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));

  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));

  sl.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(sl()));

  // Cubits
  sl.registerSingleton<RemoteArticleCubit>(
    RemoteArticleCubit(getArticleUseCase: sl()),
  );

  sl.registerSingleton<LocalArticleCubit>(
    LocalArticleCubit(
      getSavedArticleUseCase: sl(),
      removeArticleUseCase: sl(),
      saveArticleUseCase: sl(),
    ),
  );
}
