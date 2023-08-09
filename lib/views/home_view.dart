import 'package:digifood_test/res/app_colors.dart';
import 'package:digifood_test/res/app_icons.dart';
import 'package:digifood_test/res/app_strings.dart';
import 'package:digifood_test/res/app_styles.dart';
import 'package:digifood_test/views/widgets/ads_banner_widget.dart';
import 'package:digifood_test/views/widgets/article_card_widget.dart';
import 'package:digifood_test/views/widgets/chip_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import '../providers/articles_provider.dart';
import '../providers/cart_provider.dart';
import '../utils/routes/routes_name.dart';
import '../utils/static_list.dart';
import 'detail_view.dart';

final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(articlesProvider);
    final currentIndex = ref.watch(currentIndexProvider);
    final cart = ref.watch(cartProvider);
    final searchText = ref.read(searchTextProvider);
    final searchCategory = ref.read(categoryProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.kSecondaryColor,
          title: SvgPicture.asset(
            AppIcons.LOGO,
            width: 180.0,
            color: AppColors.kLightBackground,
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
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                // Ads banner section
                const AdsBannerWidget(),
                // Chip section
                SizedBox(
                  height: 50.0,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(4.0),
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        ref.read(categoryProvider.notifier).state =
                            categories[index];
                      },
                      child: ChipWidget(
                        chipLabel: categories[index],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: AppColors.kLightBackground,
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    initialValue: searchText,
                    style: AppStyles.searchText,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search,
                            color: AppColors.kPrimaryColor, size: 30.0),
                        hintText: AppString.searchHintText,
                        hintStyle: AppStyles.searchText,
                        border: InputBorder.none),
                    onChanged: (value) =>
                        {ref.read(searchTextProvider.notifier).state = value},
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                searchText.isEmpty &&
                        searchCategory.isEmpty &&
                        searchCategory != AppString.all
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(AppString.hotSales,
                                  style: AppStyles.kHeadingOne),
                              Text(
                                AppString.seeAll,
                                style: AppStyles.kSeeAllText,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            width: double.infinity,
                            height: 300.0,
                            child: articles.when(
                              data: (data) {
                                return ListView.builder(
                                  padding: const EdgeInsets.all(4.0),
                                  itemCount: 4,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      ArticleCardWidget(article: data[index]),
                                );
                              },
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              error: (error, e) => Center(
                                child: Text(error.toString()),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(AppString.featuredProducts,
                        style: AppStyles.kHeadingOne),
                    Text(
                      AppString.seeAll,
                      style: AppStyles.kSeeAllText,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                articles.when(
                  data: (data) {
                    return (searchText.isNotEmpty && data.isEmpty) || (searchCategory.isNotEmpty && data.isEmpty)
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  AppIcons.NO_RESULT,
                                  height: 150.0,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const Text(
                                  AppString.noResult,
                                  style: AppStyles.kEmptyCart,
                                )
                              ],
                            ),
                          )
                        : MasonryGridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutesName.details,
                                    arguments:
                                        DetailsView(article: data[index]));
                              },
                              child: SizedBox(
                                height: 250.0,
                                child: ArticleCardWidget(article: data[index]),
                              ),
                            ),
                          );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, e) => Center(
                    child: Text(error.toString()),
                  ),
                )
              ],
            ),
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
      ),
    );
  }
}
