import 'package:flutter/material.dart';
import 'package:shartflix_movie_app_case/core/constants/app_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Home Screen', style: Theme.of(context).textTheme.bodyLarge),
          Text('Home Screen', style: Theme.of(context).textTheme.bodyMedium),
          Text('Home Screen', style: Theme.of(context).textTheme.bodySmall),
          Container(
            color: Theme.of(context).shadowColor,
            child: Column(
              children: [
                Text(
                  'Home Screen',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  'Home Screen',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  'Home Screen',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          AppIcons.icon(AppIcons.home),
        ],
      ),
    );
  }
}
