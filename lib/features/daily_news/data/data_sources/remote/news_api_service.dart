import 'package:dio/dio.dart';
import 'package:news_app_clean_architecture/core/constants/contants.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/models/article.dart';

class NewsApiService {
  final Dio _dio;

  NewsApiService(this._dio);

  Future<Response<List<ArticleModel>>> getNewsArticles({
    String? apiKey,
    String? country,
    String? category,
  }) async {
    try {
      final response = await _dio.get(
        '$newsAPIBaseUrl/top-headlines',
        queryParameters: {
          'apiKey': apiKey,
          'country': country,
          'category': category,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['articles'];

        final List<ArticleModel> articles = data
            .map((json) => ArticleModel.fromJson(json))
            .toList();
        return Response(
          requestOptions: response.requestOptions,
          data: articles,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
        );
      } else {
        throw Exception(
          'Failed to retrieve the news: ${response.statusMessage}',
        );
      }
    } on DioException catch (_) {
      rethrow;
    }
  }
}
