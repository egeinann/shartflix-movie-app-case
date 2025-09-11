import 'package:flutter/material.dart';
import 'package:shartflix_movie_app_case/core/constants/app_icons.dart';
import 'package:shartflix_movie_app_case/core/constants/strings.dart';
import 'package:shartflix_movie_app_case/core/extensions/theme_extension.dart';
import 'package:shartflix_movie_app_case/features/movie/view/home_screen.dart';
import 'package:shartflix_movie_app_case/features/movie/view/profile_screen.dart';
import 'package:shartflix_movie_app_case/core/widgets/shadow_effect.dart';

class ControllerScreen extends StatefulWidget {
  const ControllerScreen({super.key});

  @override
  State<ControllerScreen> createState() => _ControllerScreenState();
}

class _ControllerScreenState extends State<ControllerScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: Stack(
          children: [
            AppBackground.lightEffect(highLight: false),
            selectedIndex == 0 ? HomeScreen() : ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          height: 50,
          child: Row(
            children: [
              homeButton(context),
              const SizedBox(width: 10),
              profileButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // *** PROFILE BUTTON ***
  Expanded profileButton(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedIndex = 1),
        child: AnimatedContainer(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: selectedIndex == 1
                  ? [context.theme.highlightColor, context.theme.primaryColor]
                  : [Colors.transparent, Colors.transparent],
            ),

            border: Border.all(
              color: selectedIndex == 0
                  ? Colors.white.withAlpha(50)
                  : Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(42),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppIcons.icon(
                selectedIndex == 0 ? AppIcons.profile : AppIcons.profileFill,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              Text(
                "Profile",
                style: context.textTheme.bodyLarge?.copyWith(
             
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFontFamilies.instrumentSansMedium,
                  color: Colors.white,
                  fontSize: 14,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  // *** HOME BUTTON ***
  Expanded homeButton(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedIndex = 0),
        child: AnimatedContainer(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: selectedIndex == 0
                  ? [context.theme.highlightColor, context.theme.primaryColor]
                  : [Colors.transparent, Colors.transparent],
            ),

            border: Border.all(
              color: selectedIndex == 1
                  ? context.theme.shadowColor.withAlpha(50)
                  : Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(42),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppIcons.icon(
                selectedIndex == 1 ? AppIcons.home : AppIcons.homeFill,
                color: selectedIndex == 1
                    ? context.theme.shadowColor
                    : Colors.white,
              ),
              SizedBox(width: 5),
              Text(
                "Ana Sayfa",
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFontFamilies.instrumentSansMedium,
                  color: selectedIndex == 1
                      ? context.theme.shadowColor
                      : Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
