import 'package:digifood_test/res/app_icons.dart';
import 'package:digifood_test/res/app_styles.dart';
import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../../res/app_strings.dart';

class AdsBannerWidget extends StatelessWidget {
  const AdsBannerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170.0,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  AppString.bannerTitle,
                  style: AppStyles.kBigTitle,
                ),
                Text(
                  AppString.bannerMessage,
                  style: AppStyles.kBodyText
                      .copyWith(color: AppColors.kWhiteColor),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kWhiteColor,
                      foregroundColor: AppColors.kSecondaryColor,
                    ),
                    onPressed: () {},
                    child: const Text(AppString.bannerButtonText))
              ],
            ),
          ),
        ),
        Image.asset(AppIcons.BANNER_IMAGE),
      ]),
    );
  }
}
