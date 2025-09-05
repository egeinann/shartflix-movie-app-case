import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/utils/images.dart';
import 'package:shartflix_movie_app_case/view/auth/login_screen.dart';
import 'package:shartflix_movie_app_case/widgets/filled_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

double opacityBackground = 0.0;
double opacityWidgets = 0.0;

class _OnboardingScreenState extends State<OnboardingScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        opacityBackground = 1.0;
        opacityWidgets = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backgroundImage(),
          backgroundOpacityContainer(),
          bottomColumnWidgets(context),
        ],
      ),
    );
  }

  // *** ARKAPLAN RESMİ ***
  AnimatedOpacity backgroundImage() {
    return AnimatedOpacity(
          opacity: opacityBackground,
          duration: const Duration(milliseconds: 500),
          child: Positioned.fill(
            child: Image.asset(
              AppImages.onboardingBackground,
              fit: BoxFit.cover,
            ),
          ),
        );
  }

  // *** ARKAPLAN OPAKLIK ***
  Container backgroundOpacityContainer() {
    return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Theme.of(context).scaffoldBackgroundColor.withAlpha(250), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        );
  }

  // *** ALT KIISMDAKİ WIDGETLAR ***
  AnimatedOpacity bottomColumnWidgets(BuildContext context) {
    return AnimatedOpacity(
          opacity: opacityWidgets,
          duration: const Duration(milliseconds: 500),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "The world of cinema in your pocket. Every movie an adventure, every series a discovery.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: 100.w,
                    child: CustomFilledButton(
                      text: "Get Started",
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
