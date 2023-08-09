import 'package:digifood_test/models/article.dart';
import 'package:digifood_test/res/app_colors.dart';
import 'package:digifood_test/res/app_styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/cart_provider.dart';

class ArticleCardWidget extends ConsumerWidget {
  const ArticleCardWidget({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0.0, 6.0),
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.0,
              spreadRadius: 2.0),
        ],
      ),
      margin: const EdgeInsets.all(12.0),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12.0),
              child: Image.network(article.imgUrl!),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                article.title!,
                style: AppStyles.kCardTitle,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                article.shortDescription!,
                style: AppStyles.kBodyText,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${article.price}',
                    style: AppStyles.kCardTitle,
                  ),
                  IconButton(
                      onPressed: () {
                        ref
                            .read(cartProvider.notifier)
                            .addArticleToCart(article);
                      },
                      icon: const Icon(
                        Icons.add_circle,
                        size: 30.0,
                      ))
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }
}
