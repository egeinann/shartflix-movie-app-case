import 'package:flutter/cupertino.dart';
import 'package:shartflix_movie_app_case/features/movie/view/controller_screen.dart';
import 'package:shartflix_movie_app_case/features/photo/view/add_photo_screen.dart';
import 'package:shartflix_movie_app_case/features/movie/view/settings_screen.dart';
import 'package:shartflix_movie_app_case/features/auth/view/login_screen.dart';
import 'package:shartflix_movie_app_case/features/auth/view/register_screen.dart';
import 'package:shartflix_movie_app_case/features/splash/splash_screen.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // *** NORMAL SAYFA GEÇİŞİ ***
  Future<dynamic>? navigateTo(String routeName, {Object? arguments}) {
    final context = navigatorKey.currentContext;
    if (context == null) return null;

    final route = _buildCupertinoRoute(context, routeName, arguments);
    return Navigator.of(context).push(route);
  }

  // ** GEÇİŞ YAPTIKTAN SONRA, ARKADAKİ 1 SAYFAYI KAPAT ***
  Future<dynamic>? replaceWith(String routeName, {Object? arguments}) {
    final context = navigatorKey.currentContext;
    if (context == null) return null;

    final route = _buildCupertinoRoute(context, routeName, arguments);
    return Navigator.of(context).pushReplacement(route);
  }

  // *** ARKADAİ TÜM SAYFALARI KAPAT ***
  Future<dynamic>? clearStackAndGo(String routeName, {Object? arguments}) {
    final context = navigatorKey.currentContext;
    if (context == null) return null;

    final route = _buildCupertinoRoute(context, routeName, arguments);
    return Navigator.of(context).pushAndRemoveUntil(route, (_) => false);
  }

  // ** POP ***
  void goBack() {
    navigatorKey.currentState?.pop();
  }

  Route<dynamic> _buildCupertinoRoute(
    BuildContext context,
    String routeName,
    Object? arguments,
  ) {
    final routes = {
      '/splash': (context) => const SplashScreen(),
      '/login': (context) => const LoginScreen(),
      '/register': (context) => const RegisterScreen(),
      '/addphoto': (context) => const AddPhotoScreen(),
      '/controller': (context) => const ControllerScreen(),
      '/settings': (context) => const SettingsScreen(),
    };

    final builder = routes[routeName];
    if (builder == null) {
      throw Exception('Route not found: $routeName');
    }

    return CupertinoPageRoute(
      builder: (ctx) => builder(ctx),
      settings: RouteSettings(name: routeName, arguments: arguments),
    );
  }
}
