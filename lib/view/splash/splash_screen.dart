import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shartflix_movie_app_case/view/onboarding/onboarding_screen.dart';
import 'package:shartflix_movie_app_case/widgets/shaderMaskWidget.dart';

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
      duration: const Duration(
        milliseconds: 1500,
      ), 
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
      TweenSequenceItem(
        tween: ConstantTween(const Offset(0, 0)),
        weight: 1.5,
      ),

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
          CupertinoPageRoute(
                builder: (context) => OnboardingScreen(),
              ),
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
      body: Center(
        child: SlideTransition(
          position: _slideAnimation,
          child: shaderMaskWidget(
            context,
            Text("SHARTFLIX", style: Theme.of(context).textTheme.labelLarge),
          ),
        ),
      ),
    );
  }
}
