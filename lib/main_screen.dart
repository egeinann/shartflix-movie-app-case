import 'package:flutter/material.dart';
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
        color: Colors.transparent,
        padding: const EdgeInsets.all(8),
        height: 70,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => selectedIndex = 0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedIndex == 0 ? Colors.red : Colors.transparent,
                    border: Border.all(
                      color: selectedIndex == 0 ? Colors.red : Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Page 1',
                    style: TextStyle(
                      color: selectedIndex == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => selectedIndex = 1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedIndex == 1 ? Colors.red : Colors.transparent,
                    border: Border.all(
                      color: selectedIndex == 1 ? Colors.red : Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Page 2',
                    style: TextStyle(
                      color: selectedIndex == 1 ? Colors.white : Colors.black,
                    ),
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