import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/constants/app_icons.dart';
import 'package:shartflix_movie_app_case/core/constants/images.dart';
import 'package:shartflix_movie_app_case/core/extensions/theme_extension.dart';
import 'package:shartflix_movie_app_case/core/services/auth_service.dart';
import 'package:shartflix_movie_app_case/core/services/navigation_service.dart';
import 'package:shartflix_movie_app_case/core/widgets/social_container.dart';
import 'package:shartflix_movie_app_case/core/widgets/checkBox.dart';
import 'package:shartflix_movie_app_case/core/widgets/customTextField.dart';
import 'package:shartflix_movie_app_case/core/widgets/filled_button.dart';
import 'package:shartflix_movie_app_case/core/widgets/shadow_effect.dart';
import 'package:shartflix_movie_app_case/features/auth/view/add_photo_screen.dart';
import 'package:shartflix_movie_app_case/features/auth/viewmodel/auth_cubit.dart';
import 'package:shartflix_movie_app_case/features/auth/viewmodel/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _titleAnim;
  late Animation<Offset> _formAnim;
  late Animation<Offset> _socialAnim;
  late Animation<Offset> _footerAnim;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retryPasswordController = TextEditingController();
  bool nameError = false;
  bool emailError = false;
  bool passwordError = false;
  bool retryPasswordError = false;
  bool isChecked = false;
  double opacity = 0.0;
  @override
  void initState() {
    super.initState();
    // *** GENEL EKRAN OPACTY ANİMASYONU ***
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        opacity = 1.0;
      });
    });
    // *** ANİMASYON KONTROLCÜSÜ ***
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
    // *** SOCIAL CONTAINERS ANİMASYONU ***
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    retryPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => AuthCubit(AuthServices()),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.error != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error!)));
            }
            if (state.user != null) {
              Future.microtask(() {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const AddPhotoScreen()),
                );
              });
            }
          },
          builder: (context, state) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(milliseconds: 500),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    AppBackground.lightEffect(),
                    SafeArea(
                      child: Center(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              logoHeader(context),
                              forms(),
                              socialContainers(context),
                              footer(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // *** FOOTER ***
  SlideTransition footer(BuildContext context) {
    return SlideTransition(
      position: _footerAnim,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hesabın var mı?",
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
          ),
          TextButton(
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: () => NavigationService().goBack(),
            child: Text(
              "Giriş Yap",
              style: context.theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  // *** SOCIAL CONTAINERS ***
  SlideTransition socialContainers(BuildContext context) {
    return SlideTransition(
      position: _socialAnim,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          socialContainer(context, AppIcons.apple, () {}),
          socialContainer(context, AppIcons.facebook, () {}),
          socialContainer(context, AppIcons.google, () {}),
        ],
      ),
    );
  }

  // *** TEXTFILEDS AND BUTTON AREA ***
  SlideTransition forms() {
    final cubit = context.read<AuthCubit>();
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
              prefixIcon: AppIcons.icon(AppIcons.profile),
              controller: nameController,
              hasError: false,
              hinttext: "Ad Soyad",
              lenght: 20,
              onChanged: cubit.nameChanged,
            ),

            CustomTextField(
              prefixIcon: AppIcons.icon(AppIcons.mail),
              controller: emailController,
              hasError: false,
              hinttext: "E-Posta",
              lenght: 20,
              onChanged: cubit.emailChanged,
            ),
            CustomTextField(
              prefixIcon: AppIcons.icon(AppIcons.lock),
              controller: passwordController,
              hasError: false,
              hinttext: "Şifre",
              lenght: 20,
              showPasswordToggle: true,
              onChanged: cubit.passwordChanged,
            ),
            CustomTextField(
              prefixIcon: AppIcons.icon(AppIcons.lock),
              controller: retryPasswordController,
              hasError: false,
              hinttext: "Şifre tekrar",
              lenght: 20,
              showPasswordToggle: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCheckBox(
                  isSelected: isChecked,
                  onTap: () {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Text.rich(
                    TextSpan(
                      text: '',
                      children: [
                        TextSpan(
                          text: "Kullanıcı sözleşmesini",
                          style: context.textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).shadowColor.withAlpha(120),
                              ),
                        ),
                        TextSpan(
                          text: " okudum ve kabul ediyorum.",
                          style: context.textTheme.bodySmall
                              ?.copyWith(decoration: TextDecoration.underline),
                        ),
                        TextSpan(
                          text: " Bu\n",
                          style: context.textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).shadowColor.withAlpha(120),
                              ),
                        ),
                        TextSpan(
                          text: "sözleşmeyi okuyarak devam ediniz lütfen.",
                          style: context.textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).shadowColor.withAlpha(120),
                              ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 100.w,
              child: CustomFilledButton(
                text: "Kaydol",
                onPressed: () {
                  isChecked
                      ? cubit.register()
                      : debugPrint("sözleşmeyi kabul et");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // *** LOGO TITLE AREA ***
  SlideTransition logoHeader(BuildContext context) {
    return SlideTransition(
      position: _titleAnim,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.logo),
          Text(
            "Hesap oluştur",
            style: context.textTheme.labelMedium?.copyWith(
              color: context.theme.shadowColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Kullanıcı bilgilerini girerek kaydol",
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w200),
          ),
        ],
      ),
    );
  }
}
