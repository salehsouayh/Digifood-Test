import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  static const kBigTitle = TextStyle(
    color: AppColors.kWhiteColor,
    fontSize: 25.0,
    fontWeight: FontWeight.bold,
  );

  static const kHeadingOne = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  static const kSeeAllText = TextStyle(color: AppColors.kPrimaryColor);
  static const searchText =
      TextStyle(color: AppColors.kPrimaryColor, fontSize: 14.0, height: 1.5);

  static final kBodyText = TextStyle(
    color: Colors.grey.shade500,
    fontSize: 12.0,
  );

  static const kCardTitle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  static const kEmptyCart = TextStyle(
    color: AppColors.kSecondaryColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}
