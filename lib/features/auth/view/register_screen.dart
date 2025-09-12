import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/constants/app_icons.dart';
import 'package:shartflix_movie_app_case/core/constants/images.dart';
import 'package:shartflix_movie_app_case/core/constants/lotties.dart';
import 'package:shartflix_movie_app_case/core/extensions/theme_extension.dart';
import 'package:shartflix_movie_app_case/core/services/auth_service.dart';
import 'package:shartflix_movie_app_case/core/services/navigation_service.dart';
import 'package:shartflix_movie_app_case/core/widgets/social_container.dart';
import 'package:shartflix_movie_app_case/core/widgets/checkBox.dart';
import 'package:shartflix_movie_app_case/core/widgets/customTextField.dart';
import 'package:shartflix_movie_app_case/core/widgets/filled_button.dart';
import 'package:shartflix_movie_app_case/core/widgets/shadow_effect.dart';
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
  bool showAgreementError = false;
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
    return BlocProvider(
      create: (_) => AuthCubit(AuthServices()),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.isSuccess && state.user != null) {
              NavigationService().clearStackAndGo('/addphoto');
            }
          },
          builder: (context, state) {
            final cubit = context.read<AuthCubit>();
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
                              forms(cubit),
                              socialContainers(context),
                              footer(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Animasyonlu Loading Overlay
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return AnimatedOpacity(
                          opacity: state.isLoading ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          child: IgnorePointer(
                            ignoring: !state
                                .isLoading, // Loading değilken UI interaktif
                            child: Container(
                              color: Colors.black.withAlpha(150),
                              child: Center(
                                child: Lottie.asset(
                                  AppLotties.loading,
                                  width: 150,
                                  height: 150,
                                  repeat: true,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
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
            child: Text("Giriş Yap", style: context.theme.textTheme.bodySmall),
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
  SlideTransition forms(AuthCubit cubit) {
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
              hasError: cubit.state.nameError,
              hinttext: "Ad Soyad",
              lenght: 20,
              onChanged: (val) {
                cubit.nameChanged(val);
                cubit.clearErrorIfValid(name: val);
              },
            ),

            CustomTextField(
              prefixIcon: AppIcons.icon(AppIcons.mail),
              controller: emailController,
              hasError: cubit.state.emailError,
              hinttext: "E-Posta",
              lenght: 30,
              onChanged: (val) {
                cubit.emailChanged(val);
                cubit.clearErrorIfValid(email: val);
              },
            ),

            CustomTextField(
              prefixIcon: AppIcons.icon(AppIcons.lock),
              controller: passwordController,
              hasError: cubit.state.passwordError,
              hinttext: "Şifre",
              lenght: 18,
              showPasswordToggle: true,
              onChanged: (val) {
                cubit.passwordChanged(val);
                cubit.clearErrorIfValid(
                  password: val,
                  retryPassword: retryPasswordController.text,
                );
              },
            ),

            CustomTextField(
              prefixIcon: AppIcons.icon(AppIcons.lock),
              controller: retryPasswordController,
              hasError: cubit.state.retryPasswordError,
              hinttext: "Şifre tekrar",
              lenght: 18,
              showPasswordToggle: true,
              onChanged: (val) {
                cubit.clearErrorIfValid(
                  password: passwordController.text,
                  retryPassword: val,
                );
              },
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
                      showAgreementError = !showAgreementError;
                    });
                  },
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Kullanıcı sözleşmesini",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: showAgreementError
                                ? Colors.red
                                : Theme.of(context).shadowColor.withAlpha(120),
                          ),
                        ),
                        TextSpan(
                          text: " okudum ve kabul ediyorum.",
                          style: context.textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.underline,
                            color: showAgreementError
                                ? Colors.red
                                : Theme.of(context).shadowColor.withAlpha(120),
                          ),
                        ),
                        TextSpan(
                          text: " Bu\n",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: showAgreementError
                                ? Colors.red
                                : Theme.of(context).shadowColor.withAlpha(120),
                          ),
                        ),
                        TextSpan(
                          text: "sözleşmeyi okuyarak devam ediniz lütfen.",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: showAgreementError
                                ? Colors.red
                                : Theme.of(context).shadowColor.withAlpha(120),
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
                  if (!isChecked) {
                    setState(() {
                      showAgreementError = true;
                    });
                    return; // kayıt işlemini durdur
                  }

                  // Checkbox işaretliyse validate ve register işlemi
                  cubit.validateFields(
                    retryPassword: retryPasswordController.text,
                  );

                  if (!cubit.state.nameError &&
                      !cubit.state.emailError &&
                      !cubit.state.passwordError &&
                      !cubit.state.retryPasswordError) {
                    cubit.register();
                  }
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
