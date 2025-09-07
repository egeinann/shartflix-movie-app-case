import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/constants/app_icons.dart';
import 'package:shartflix_movie_app_case/core/constants/images.dart';
import 'package:shartflix_movie_app_case/core/constants/lotties.dart';
import 'package:shartflix_movie_app_case/view/auth/view/register_screen.dart';
import 'package:shartflix_movie_app_case/view/auth/widgets/social_container.dart';
import 'package:shartflix_movie_app_case/view/auth/widgets/customTextField.dart';
import 'package:shartflix_movie_app_case/widgets/filled_button.dart';
import 'package:shartflix_movie_app_case/widgets/shadow_effect.dart';

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
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        opacity = 1.0;
      });
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    // *** logoHeader methodu animasyonu ***
    _titleAnim = Tween<Offset>(begin: const Offset(2, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
          ),
        );
    // *** forms methodu animasyonu ***
    _formAnim = Tween<Offset>(begin: const Offset(2, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
          ),
        );
    // *** socialContainers methodu animasyonu ***
    _socialAnim = Tween<Offset>(begin: const Offset(2, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
          ),
        );
    // *** footer methodu animasyonu ***
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
          duration: const Duration(seconds: 1),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              AppBackground.lightEffect(),
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Lottie.asset(AppLotties.artboard_1),
                      Column(
                        children: [
                          logoHeader(context),
                          forms(context),
                          socialContainers(context),
                          footer(context),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // *** LOGO VE TITLE KISMI ***
  SlideTransition logoHeader(BuildContext context) {
    return SlideTransition(
      position: _titleAnim,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.logo),
          Text(
            "Giriş yap",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).shadowColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Kullanıcı bilgilerinle giriş yap",
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w200),
          ),
        ],
      ),
    );
  }

  // *** TEXTFIELDS KISMI VE BUTTON ***
  SlideTransition forms(BuildContext context) {
    return SlideTransition(
      position: _formAnim,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 15,
          children: [
            CustomTextField(
              prefixIcon: AppIcons.icon(AppIcons.mail),
              controller: TextEditingController(),
              hasError: true,
              hinttext: "E-Posta",
              lenght: 20,
            ),

            CustomTextField(
              prefixIcon: AppIcons.icon(AppIcons.lock),
              controller: TextEditingController(),
              hasError: true,
              showPasswordToggle: true,
              hinttext: "Şifre",
              lenght: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Şifre unuttum",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              width: 100.w,
              child: CustomFilledButton(onPressed: () {}, text: "Giriş Yap"),
            ),
          ],
        ),
      ),
    );
  }

  // *** FOOTER REGISTER KISMI ****
  SlideTransition footer(BuildContext context) {
    return SlideTransition(
      position: _footerAnim,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Bir hesabın yok mu?",
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
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
              "Kayıt ol",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  // *** CONTAINERS ***
  SlideTransition socialContainers(BuildContext context) {
    return SlideTransition(
      position: _socialAnim,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              socialContainer(context, AppIcons.apple, () {}),
              socialContainer(context, AppIcons.facebook, () {}),
              socialContainer(context, AppIcons.google, () {}),
            ],
          ),
        ],
      ),
    );
  }
}
