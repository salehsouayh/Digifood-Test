import 'package:digifood_test/models/article.dart';
import 'package:digifood_test/res/app_colors.dart';
import 'package:digifood_test/res/app_strings.dart';
import 'package:digifood_test/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cart_provider.dart';
import '../utils/routes/routes_name.dart';
import 'home_view.dart';

final currentNumberProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

class DetailsView extends ConsumerWidget {
  DetailsView({super.key, required this.article});

  Article article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final cart = ref.watch(cartProvider);
    final currentNumber = ref.watch(currentNumberProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kSecondaryColor,
        title: Text(
          article.title!,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 10.0),
              child: Badge(
                label: Text(cart.length.toString()),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutesName.cart);
                    },
                    icon: const Icon(
                      Icons.local_mall,
                      size: 24.0,
                    )),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300.0,
              width: double.infinity,
              color: AppColors.kLightBackground,
              child: Image.network(article.imgUrl!),
            ),
            Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title!,
                    style: AppStyles.kBigTitle
                        .copyWith(color: AppColors.kPrimaryColor),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    children: [
                      RatingBar(
                        itemSize: 20.0,
                        initialRating: 1.0,
                        minRating: 1.0,
                        maxRating: 5.0,
                        allowHalfRating: true,
                        ratingWidget: RatingWidget(
                          empty: const Icon(
                            Icons.star_border,
                            color: Colors.amber,
                          ),
                          full: const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          half: const Icon(
                            Icons.star_half_sharp,
                            color: Colors.amber,
                          ),
                        ),
                        onRatingUpdate: (value) => null,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Text('${article.review} ${AppString.review}')
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(article.longDescription!),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${article.price! * currentNumber}',
                        style: AppStyles.kHeadingOne,
                      ),
                      Row(children: [
                        IconButton(
                          onPressed: () {
                            if (currentNumber > 0) {
                              ref
                                  .read(currentNumberProvider.notifier)
                                  .update((state) => state -= 1);
                            }
                          },
                          icon: const Icon(
                            Icons.do_not_disturb_on_outlined,
                            size: 30.0,
                          ),
                        ),
                        Text(
                          currentNumber.toString(),
                          style: AppStyles.kCardTitle.copyWith(fontSize: 24),
                        ),
                        IconButton(
                            onPressed: () {
                              ref
                                  .read(currentNumberProvider.notifier)
                                  .update((state) => state += 1);
                            },
                            icon: const Icon(
                              Icons.add_circle_outline,
                              size: 30.0,
                            ))
                      ]),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kPrimaryColor,
                        minimumSize: const Size(double.infinity, 50.0)),
                    onPressed: () {
                      ref
                          .read(cartProvider.notifier)
                          .addArticleToCart(article, qty: currentNumber);
                    },
                    child: const Text(AppString.addArticle),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) =>
            ref.read(currentIndexProvider.notifier).update((state) => value),
        selectedItemColor: AppColors.kPrimaryColor,
        unselectedItemColor: AppColors.kSecondaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            activeIcon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorite',
            activeIcon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: 'Location',
            activeIcon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notification',
            activeIcon: Icon(Icons.notifications),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
            activeIcon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
