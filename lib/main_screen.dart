import 'package:flutter/material.dart';
import 'package:shartflix_movie_app_case/core/utils/app_icons.dart';
import 'package:shartflix_movie_app_case/core/utils/strings.dart';
import 'package:shartflix_movie_app_case/home_screen.dart';
import 'package:shartflix_movie_app_case/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(child: selectedIndex == 0 ? HomeScreen() : ProfileScreen()),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),

        height: 50,
        child: Row(
          children: [
            Expanded(
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
                          ? [
                              Theme.of(context).highlightColor,
                              Theme.of(context).primaryColor,
                            ]
                          : [Colors.transparent, Colors.transparent],
                    ),

                    border: Border.all(
                      color: selectedIndex == 1
                          ? Colors.grey
                          : Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppIcons.icon(
                        selectedIndex == 1 ? AppIcons.home : AppIcons.homeFill,
                        color: selectedIndex == 1 ? Colors.black : Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Home",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFontFamilies.instrumentSansRegular,
                          color: selectedIndex == 1
                              ? Theme.of(context).shadowColor
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
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
                          ? [
                              Theme.of(context).highlightColor,
                              Theme.of(context).primaryColor,
                            ]
                          : [Colors.transparent, Colors.transparent],
                    ),

                    border: Border.all(
                      color: selectedIndex == 0
                          ? Colors.grey
                          : Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppIcons.icon(
                        selectedIndex == 0
                            ? AppIcons.profile
                            : AppIcons.profileFill,
                        color: selectedIndex == 0 ? Colors.black : Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFontFamilies.instrumentSansRegular,
                          color: selectedIndex == 0
                              ? Theme.of(context).shadowColor
                              : Colors.white,
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
  }
}
