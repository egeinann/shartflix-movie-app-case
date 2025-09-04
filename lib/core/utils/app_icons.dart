import 'package:flutter/material.dart';

class AppIcons {
  static const String arrow = 'assets/icons/Arrow.png';
  static const String gem = 'assets/icons/Gem.png';
  static const String heartFill = 'assets/icons/Heart-fill.png';
  static const String heart = 'assets/icons/Heart.png';
  static const String hide = 'assets/icons/Hide.png';
  static const String homeFill = 'assets/icons/Home-fill.png';
  static const String home = 'assets/icons/Home.png';
  static const String lock = 'assets/icons/Lock.png';
  static const String mail = 'assets/icons/Mail.png';
  static const String plus = 'assets/icons/Plus.png';
  static const String profileFill = 'assets/icons/Profile-fill.png';
  static const String profile = 'assets/icons/Profile.png';
  static const String see = 'assets/icons/See.png';
  static const String user = 'assets/icons/User.png';
  static const String x = 'assets/icons/X.png';
  static const String apple = 'assets/socialIcons/Apple.png';
  static const String facebook = 'assets/socialIcons/Facebook.png';
  static const String google = 'assets/socialIcons/Google.png';

  static Widget icon(
    String path, {
    Color? color,
    double size = 24,
  }) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return ImageIcon(
          AssetImage(path),
          size: size,
          color: color ?? (isDark ? null : Theme.of(context).iconTheme.color),
        );
      },
    );
  }
}
