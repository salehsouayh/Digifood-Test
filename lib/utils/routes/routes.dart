import 'package:digifood_test/res/app_strings.dart';
import 'package:flutter/material.dart';
import '../../views/cart_view.dart';
import '../../views/detail_view.dart';
import '../../views/home_view.dart';
import 'routes_name.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeView(),
        );
      case AppRoutesName.cart:
        return MaterialPageRoute(
          builder: (BuildContext context) => const CardView(),
        );
      case AppRoutesName.details:
        final args = settings.arguments as DetailsView;
        return MaterialPageRoute(
          builder: (BuildContext context) => DetailsView(
            article: args.article,
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text(AppString.noRoute),
            ),
          );
        });
    }
  }
}
