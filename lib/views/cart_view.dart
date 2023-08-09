import 'package:digifood_test/res/app_colors.dart';
import 'package:digifood_test/res/app_icons.dart';
import 'package:digifood_test/res/app_strings.dart';
import 'package:digifood_test/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cart_provider.dart';

class CardView extends ConsumerWidget {
  const CardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kSecondaryColor,
        title: const Text(AppString.myCart),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.local_mall)))
        ],
      ),
      body: cart.isNotEmpty
          ? Column(children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) => Dismissible(
                      background: Container(
                        color: Colors.red,
                        child: const Center(
                            child: Text(
                          AppString.swipeToDismiss,
                          style: AppStyles.kBigTitle,
                        )),
                      ),
                      direction: DismissDirection.endToStart,
                      key: Key(cart[index].id!),
                      onDismissed: (direction) {
                        ref
                            .read(cartProvider.notifier)
                            .removeArticleFromCart(cart[index], true);
                      },
                      child: Card(
                        child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          height: 75.0,
                          child: Row(children: [
                            Expanded(
                              flex: 1,
                              child: Image.network(cart[index].imgUrl!),
                            ),
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cart[index].title!,
                                        style: AppStyles.kCardTitle,
                                      ),
                                      const SizedBox(
                                        height: 6.0,
                                      ),
                                      Text(
                                        cart[index].shortDescription!,
                                        style: AppStyles.kBodyText,
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        '\$${cart[index].price}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(cart[index].qty.toString()),
                                GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(cartProvider.notifier)
                                          .removeArticleFromCart(
                                              cart[index], false);
                                    },
                                    child: const Icon(Icons.minimize))
                              ],
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '${AppString.total}:',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kPrimaryColor),
                        ),
                        Text(
                          '\$${ref.watch(priceCalcProvider)}',
                          style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kPrimaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ])
          : Center(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppIcons.EMPTY_CART,
                  height: 250.0,
                ),
                const Text(
                  AppString.emptyCart,
                  style: AppStyles.kEmptyCart,
                )
              ],
            )),
    );
  }
}
