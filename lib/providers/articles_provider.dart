import 'package:digifood_test/models/article.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repository/article_repository.dart';
import '../res/app_strings.dart';

final searchTextProvider = StateProvider<String>((ref) => "");
final categoryProvider = StateProvider<String>((ref) => "");

final articlesProvider = FutureProvider<List<Article>>((ref) async {
  List<Article> articles = await ref.watch(articleRepository).getPlaylist();
  final searchText = ref.watch(searchTextProvider);
  final categoryText = ref.watch(categoryProvider);

  if (searchText.isNotEmpty) {
    List<Article> result = articles
        .where((element) =>
            element.title!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return result;
  } else if (categoryText.isNotEmpty && categoryText != AppString.all) {
    List<Article> result = articles
        .where((element) => element.category!
            .toLowerCase()
            .contains(categoryText.toLowerCase()))
        .toList();
    return result;
  } else if (categoryText == AppString.all) {
    return articles;
  } else {
    return articles;
  }
});
