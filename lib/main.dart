import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/connectivity/connectivitiy_state.dart';
import 'package:shartflix_movie_app_case/connectivity/connectivity_cubit.dart';
import 'package:shartflix_movie_app_case/core/extensions/theme_extension.dart';
import 'package:shartflix_movie_app_case/features/settings/viewmodel/language_cubit.dart';
import 'package:shartflix_movie_app_case/features/settings/viewmodel/theme_cubit.dart';
import 'package:shartflix_movie_app_case/core/services/auth_service.dart';
import 'package:shartflix_movie_app_case/core/services/movie_service.dart';
import 'package:shartflix_movie_app_case/core/services/navigation_service.dart';
import 'package:shartflix_movie_app_case/core/services/photo_service.dart';
import 'package:shartflix_movie_app_case/core/themes/themes.dart';
import 'package:shartflix_movie_app_case/features/auth/model/user_model.dart';
import 'package:shartflix_movie_app_case/features/auth/viewmodel/auth_cubit.dart';
import 'package:shartflix_movie_app_case/features/movie/viewmodel/favoriteMovie/favorite_movie_cubit.dart';
import 'package:shartflix_movie_app_case/features/movie/viewmodel/movie/movie_cubit.dart';
import 'package:shartflix_movie_app_case/features/photo/viewmodel/userPhoto_cubit.dart';
import 'package:shartflix_movie_app_case/features/splash/splash_screen.dart';

import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Servisleri başlat
  final movieServices = MovieServices();
  final authServices = AuthServices();
  final photoServices = PhotoServices();

  // Başlangıçta boş bir user
  final user = UserModel(id: '', name: '', email: '', password: '');

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('tr'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'), // fallback English
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ConnectivityCubit(Connectivity())),
          BlocProvider(create: (_) => AuthCubit(authServices)),
          BlocProvider(create: (_) => PhotoCubit(photoServices, user)),
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => LanguageCubit()),
          BlocProvider(create: (_) => MovieCubit(movieServices: movieServices)),
          BlocProvider(
            create: (_) => FavoriteMovieCubit(movieServices: movieServices),
          ),
        ],
        child: const ShartflixApp(),
      ),
    ),
  );
}

class ShartflixApp extends StatelessWidget {
  const ShartflixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, currentThemeMode) {
        return BlocBuilder<LanguageCubit, Locale>(
          builder: (context, locale) {
            if (context.locale != locale) {
              context.setLocale(locale);
            }

            return ResponsiveSizer(
              builder: (p0, p1, p2) => MaterialApp(
                navigatorKey: NavigationService().navigatorKey,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: currentThemeMode,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                builder: (context, child) {
                  // ScaffoldMessenger buraya ekleniyor
                  return BlocListener<ConnectivityCubit, ConnectivityState>(
                    listener: (context, state) {
                      if (state is ConnectivityDisconnected) {
                        debugPrint("ağ hatası");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Connection Error'.tr(),
                              style: context.textTheme.bodyLarge,
                            ),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                              top: 30,
                              left: 10,
                              right: 10,
                            ),
                            duration: Duration(seconds: 10),
                          ),
                        );
                      }
                      // İnternet geri geldiğinde snackbar gösterme
                    },
                    child: child,
                  );
                },
                home: const SplashScreen(),
              ),
            );
          },
        );
      },
    );
  }
}
