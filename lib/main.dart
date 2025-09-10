import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/bloc/theme_cubit.dart';
import 'package:shartflix_movie_app_case/core/services/auth_service.dart';
import 'package:shartflix_movie_app_case/core/services/movie_service.dart';
import 'package:shartflix_movie_app_case/core/services/navigation_service.dart';
import 'package:shartflix_movie_app_case/core/themes/themes.dart';
import 'package:shartflix_movie_app_case/features/auth/viewmodel/auth_cubit.dart';
import 'package:shartflix_movie_app_case/features/movie/viewmodel/favoriteMovie/favorite_movie_cubit.dart';
import 'package:shartflix_movie_app_case/features/movie/viewmodel/movie/movie_cubit.dart';
import 'package:shartflix_movie_app_case/features/splash/splash_screen.dart';

void main() {

  final movieServices = MovieServices();
  final authServices = AuthServices();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit(authServices)),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => MovieCubit(movieServices: movieServices)),
        BlocProvider(
          create: (_) => FavoriteMovieCubit(movieServices: movieServices),
        ),
      ],
      child: const ShartflixApp(),
    ),
  );
}

class ShartflixApp extends StatelessWidget {
  const ShartflixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return ResponsiveSizer(
          builder: (p0, p1, p2) => MaterialApp(
            navigatorKey: NavigationService().navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
