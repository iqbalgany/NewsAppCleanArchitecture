part of 'local_article_cubit.dart';

class LocalArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  const LocalArticleState({this.articles});

  @override
  List<Object> get props => [articles!];
}

final class LocalArticleLoading extends LocalArticleState {}

final class LocalArticleDone extends LocalArticleState {
  const LocalArticleDone(List<ArticleEntity> articles)
    : super(articles: articles);
}

final class LocalArticleError extends LocalArticleState {}
