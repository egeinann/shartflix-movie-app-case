import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/constants/app_icons.dart';
import 'package:shartflix_movie_app_case/core/constants/strings.dart';
import 'package:shartflix_movie_app_case/core/services/navigation_service.dart';
import 'package:shartflix_movie_app_case/core/widgets/filled_button.dart';
import 'package:shartflix_movie_app_case/core/widgets/outlined_container.dart';
import 'package:shartflix_movie_app_case/core/widgets/shadow_effect.dart';

// *** BOTTOMSHEET ***
void showBottomSheetApp(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return SizedBox(
        height: 80.h,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Opacity(
                  opacity: 0.8,
                  child: AppBackground.lightEffect(),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 1,
                  child: Opacity(
                    opacity: 0.5,
                    child: AppBackground.lightEffect(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => NavigationService().goBack(),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).canvasColor.withAlpha(150),
                        border: Border.all(
                          color: Theme.of(context).shadowColor.withAlpha(100),
                        ),
                      ),
                      child: AppIcons.icon(AppIcons.x),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 15,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 20,
                      children: [
                        Text(
                          "Sınırlı Teklif",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontFamily:
                                    AppFontFamilies.instrumentSansSemiBold,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          "Jeton paketin’ni seçerek bonus kazanın ve yeni bölümlerin kilidini açın!",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                        outlinedContainer(
                          context,
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "Alacağınız Bonuslar",
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppFontFamilies
                                            .instrumentSansMedium,
                                      ),
                                ),
                              ),
                              Row(
                                children: [
                                  bonusFeatures(
                                    context,
                                    AppPremiumIcons.premiumAccountIcon,
                                    "Premium\nHesap",
                                  ),
                                  bonusFeatures(
                                    context,
                                    AppPremiumIcons.moreMatchIcon,
                                    "Daha\nFazla Eşleşme",
                                  ),
                                  bonusFeatures(
                                    context,
                                    AppPremiumIcons.featuredIcon,
                                    "Öne\nÇıkanlar",
                                  ),
                                  bonusFeatures(
                                    context,
                                    AppPremiumIcons.moreLikesIcon,
                                    "Daha\nFazla Beğeni",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "Kilidi açmak için bir jeton paketi seçin",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontFamily:
                                      AppFontFamilies.instrumentSansMedium,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              child: priceContainer(
                                context,
                                "10",
                                "200",
                                "300",
                                "99,99",
                                Color(0xFF6F060B),
                                Theme.of(context).highlightColor,
                                () {},
                              ),
                            ),
                            Expanded(
                              child: priceContainer(
                                context,
                                "70",
                                "2000",
                                "3.375",
                                "799,99",
                                Color(0xFF5949E6),
                                Theme.of(context).highlightColor,
                                () {},
                              ),
                            ),
                            Expanded(
                              child: priceContainer(
                                context,
                                "35",
                                "1000",
                                "1.350",
                                "399,99",
                                Color(0xFF6F060B),
                                Theme.of(context).highlightColor,
                                () {},
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 100.w,
                          child: CustomFilledButton(
                            text: "Tüm Jetonları Gör",
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// *** BOTTOMSHEET WIDGET ***
Widget bonusFeatures(BuildContext context, String iconPath, String text) {
  return Expanded(
    child: SizedBox(
      height: 120,
      child: Column(
        children: [
          Expanded(child: Image.asset(iconPath)),
          Expanded(
            child: Center(
              child: FittedBox(
                child: Text(
                  text,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// *** BOTTOMSHEET WIDGET ***
Widget priceContainer(
  BuildContext context,
  String percentage,
  String oldTokens,
  String newTokens,
  String price,
  Color gradientColor1,
  Color gradientcolor2,
  VoidCallback onTap,
) {
  return Stack(
    alignment: Alignment.topCenter,
    clipBehavior: Clip.none,
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [gradientColor1, gradientcolor2],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).shadowColor.withAlpha(100),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(color: gradientColor1),
              BoxShadow(
                color: Theme.of(context).shadowColor.withAlpha(150),
                spreadRadius: 0,
                blurRadius: 1,
              ),
            ],
          ),
          child: Column(
            spacing: 15,
            children: [
              SizedBox(),
              Column(
                children: [
                  Text(
                    oldTokens,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontFamily: AppFontFamilies.instrumentSansMedium,
                      fontWeight: FontWeight.w500,

                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.white,
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      newTokens,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontFamily: AppFontFamilies.instrumentSansBold,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "Jeton",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontFamily: AppFontFamilies.instrumentSansMedium,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Text(
                    "₺"
                    "$price",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontFamily: AppFontFamilies.instrumentSansBold,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  FittedBox(
                    child: Text(
                      "Başına haftalık",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontFamily: AppFontFamilies.instrumentSansRegular,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: -12,
        left: 0,
        right: 0,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: Theme.of(context).shadowColor.withAlpha(50),
              ),
              gradient: RadialGradient(
                radius: 3, // genişlik
                colors: [gradientColor1, Theme.of(context).shadowColor],
              ),
            ),
            child: Text(
              "+"
              "$percentage"
              "%",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontFamily: AppFontFamilies.instrumentSansRegular,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
