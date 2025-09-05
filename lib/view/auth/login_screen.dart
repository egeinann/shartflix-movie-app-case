import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/utils/app_icons.dart';
import 'package:shartflix_movie_app_case/view/auth/register_screen.dart';
import 'package:shartflix_movie_app_case/widgets/customTextField.dart';
import 'package:shartflix_movie_app_case/widgets/filled_button.dart';
import 'package:shartflix_movie_app_case/widgets/shaderMaskWidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

double opacity = 0.0;

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _titleAnim;
  late Animation<Offset> _formAnim;
  late Animation<Offset> _socialAnim;
  late Animation<Offset> _footerAnim;

  @override
  void initState() {
    super.initState();
    // *** GENEL EKRAN OPACTY ANİMASYONU ***
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        opacity = 1.0;
      });
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    // *** BAŞLIK ANİMASYON ***
    _titleAnim = Tween<Offset>(begin: const Offset(2, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
          ),
        );
    // *** TEXTFIELDS ANİMASYONU ***
    _formAnim = Tween<Offset>(begin: const Offset(2, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
          ),
        );
    // *** CONTAINERS ANİMASYONU ***
    _socialAnim = Tween<Offset>(begin: const Offset(2, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
          ),
        );
    // *** FOOTER ANİMASYONU ***
    _footerAnim = Tween<Offset>(begin: const Offset(2, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
          ),
        );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [title(context), forms(), containers(), footers(context)],
          ),
        ),
      ),
    );
  }

  // *** EN ALT KISIMDAKİ FOOTERLAR ***
  SlideTransition footers(BuildContext context) {
    return SlideTransition(
      position: _footerAnim,
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            "Don't have an account?",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextButton(
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const RegisterScreen(),
                ),
              );
            },
            child: Text(
              "Register Now",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // *** ORTADAKİ SOCIAL CONTAINERS ***
  SlideTransition containers() {
    return SlideTransition(
      position: _socialAnim,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            children: [
              socialContainer(AppIcons.apple, () {}),
              socialContainer(AppIcons.facebook, () {}),
              socialContainer(AppIcons.google, () {}),
            ],
          ),
        ],
      ),
    );
  }

  // *** ORTADAKİ FORM BÖLÜMÜ ***
  SlideTransition forms() {
    return SlideTransition(
      position: _formAnim,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 10,
        children: [
          CustomTextField(
            prefixIcon: AppIcons.icon(AppIcons.mail),
            controller: TextEditingController(),
            hasError: true,
            hinttext: "E-mail",
            lenght: 20,
          ),

          CustomTextField(
            prefixIcon: AppIcons.icon(AppIcons.lock),
            controller: TextEditingController(),
            hasError: true,
            showPasswordToggle: true,
            hinttext: "Password",
            lenght: 20,
          ),

          CustomFilledButton(text: "Login", onPressed: () {}),
        ],
      ),
    );
  }

  // *** BAŞLIK TEXT ***
  SlideTransition title(BuildContext context) {
    return SlideTransition(
      position: _titleAnim,
      child: shaderMaskWidget(
        context,
        Text(
          "SHARTFLIX",
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontSize: 30.sp),
        ),
      ),
    );
  }

  // *** KOD TEKRARINI AZALTMAK İÇİN BİR FONKSİYON ***
  Widget socialContainer(String iconPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).canvasColor,
              Theme.of(context).canvasColor,
              Theme.of(context).canvasColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(iconPath),
      ),
    );
  }
}
