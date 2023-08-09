import 'package:digifood_test/models/article.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Article> cart = [];

class CartNotifier extends StateNotifier<List<Article>> {
  CartNotifier() : super(cart);

  void addArticleToCart(Article article, {int? qty}) {
    if (state.where((element) => element.id == article.id).toList().isEmpty) {
      state = [...state, article.copyWith(qty: qty ?? 1)];
    } else {
      int index = state.indexWhere((element) => element.id == article.id);
      state = [
        for (final product in state)
          if (product.id != article.id) product,
        state[index] = article.copyWith(qty: state[index].qty += qty ?? 1)
      ];
    }
  }

  void removeArticleFromCart(Article article, bool canDismiss) {
    if (canDismiss) {
      state = [
        for (final product in state)
          if (product != article) product,
      ];
    } else {
      if (article.qty == 1) {
        state = [
          for (final product in state)
            if (product != article) product,
        ];
      } else {
        int index = state.indexWhere((element) => element.id == article.id);
        state = [
          for (final product in state)
            if (product.id != article.id) product,
          state[index] = article.copyWith(qty: article.qty -= 1)
        ];
      }
    }
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<Article>>((ref) {
  return CartNotifier();
});

final priceCalcProvider = StateProvider<double>((ref) {
  final cart = ref.watch(cartProvider);

  double sum = 0;
  for (var element in cart) {
    sum += element.price! * element.qty;
  }
  return sum;
});
