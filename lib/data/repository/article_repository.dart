import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/article.dart';
import '../service/api_endpoints.dart';
import '../service/base_service.dart';
import '../service/network_service.dart';

final articleRepository =
    Provider<ArticleRepository>((ref) => ArticleRepository());

class ArticleRepository {
  BaseService baseService = NetworkService();

  Future<List<Article>> getPlaylist() async {
    dynamic response =
        await baseService.getResponse(ApiEndPoints.ARTICLES_LIST);
    final List responseList = response;
    List<Article> articles =
        responseList.map((article) => Article.fromJson(article)).toList();
    return articles;
  }
}
