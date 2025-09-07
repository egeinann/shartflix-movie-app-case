import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shartflix_movie_app_case/core/constants/images.dart';
import 'package:shartflix_movie_app_case/view/auth/view/login_screen.dart';
import 'package:shartflix_movie_app_case/widgets/shadow_effect.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _slideAnimation = TweenSequence<Offset>([
      // *** BAŞLAMA ***
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(5, 0),
          end: const Offset(0, 0),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      // *** ORTADA BEKLEME ***
      TweenSequenceItem(tween: ConstantTween(const Offset(0, 0)), weight: 1.5),
      // *** KAYBOLMA ***
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0, 0),
          end: const Offset(-5, 0),
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 0.5,
      ),
    ]).animate(_controller);
    _controller.forward();
    // *** ANİMASYON BİTİNCE SAYFA DEĞİŞ ***
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SlideTransition(
        position: _slideAnimation,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: AppBackground.lightEffect(fade: false),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logo),
                  Text(
                    "SHARTFLIX",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).shadowColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
