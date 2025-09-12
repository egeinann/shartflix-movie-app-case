import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/constants/app_icons.dart';
import 'package:shartflix_movie_app_case/core/constants/images.dart';
import 'package:shartflix_movie_app_case/core/constants/lotties.dart';
import 'package:shartflix_movie_app_case/core/constants/strings.dart';
import 'package:shartflix_movie_app_case/core/extensions/theme_extension.dart';
import 'package:shartflix_movie_app_case/core/services/auth_service.dart';
import 'package:shartflix_movie_app_case/core/services/navigation_service.dart';
import 'package:shartflix_movie_app_case/core/widgets/social_container.dart';
import 'package:shartflix_movie_app_case/core/widgets/customTextField.dart';
import 'package:shartflix_movie_app_case/core/widgets/filled_button.dart';
import 'package:shartflix_movie_app_case/core/widgets/shadow_effect.dart';
import 'package:shartflix_movie_app_case/features/auth/viewmodel/auth_cubit.dart';
import 'package:shartflix_movie_app_case/features/auth/viewmodel/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

double opacity = 0.0;
double opacityLottie = 0.0;

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _titleAnim;
  late Animation<Offset> _formAnim;
  late Animation<Offset> _socialAnim;
  late Animation<Offset> _footerAnim;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool emailError = false;
  bool passwordError = false;

  @override
  void initState() {
    super.initState();
    // *** GENEL EKRAN OPACTY ANİMASYONU ***
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        opacity = 1.0;
      });
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        opacityLottie = 1.0;
      });
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    // *** logoHeader methodu animasyonu ***
    _titleAnim = Tween<Offset>(begin: const Offset(2, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.2, 0.4, curve: Curves.easeOut),
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
    emailController.dispose();
    passwordController.dispose();
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
              debugPrint(state.error);
            }
            if (state.user != null) {
              NavigationService().clearStackAndGo('/controller');
            }
          },
          builder: (context, state) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusScope.of(context).unfocus(),
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
                            SizedBox(
                              height: 20.h,
                              child: AnimatedOpacity(
                                duration: const Duration(seconds: 1),
                                opacity: opacityLottie,
                                child: Lottie.asset(AppLotties.artboard_1),
                              ),
                            ),
                            Column(
                              children: [
                                logoHeader(context),

                                forms(context, state),
                                socialContainers(context),
                                footer(context),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: state.isLoading ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      child: IgnorePointer(
                        // overlay aktifken UI etkileşimini engeller
                        ignoring: !state.isLoading,
                        child: Container(
                          color: Colors.black.withAlpha(150),
                          child: Center(
                            child: Lottie.asset(
                              AppLotties.loading,

                              repeat: true,
                            ),
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
            "Login".tr(),
            style: context.textTheme.labelMedium?.copyWith(
              color: context.theme.shadowColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Log in with your user information".tr(),
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w200),
          ),
        ],
      ),
    );
  }

  // *** TEXTFIELDS KISMI VE BUTTON ***
  SlideTransition forms(BuildContext context, AuthState state) {
    final cubit = context.read<AuthCubit>();
    return SlideTransition(
      position: _formAnim,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          spacing: 15,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
              prefixIcon: AppIcons.icon(AppIcons.mail),
              controller: emailController,
              hasError: emailError || state.emailError,
              onChanged: (value) {
                setState(() {
                  // Kullanıcı yazmaya başladığında kırmızı hatayı kaldır
                  emailError = false;
                });
                cubit.emailChanged(value);
              },
              hinttext: "Email".tr(),
              lenght: 50,
            ),

            CustomTextField(
              prefixIcon: AppIcons.icon(AppIcons.lock),
              controller: passwordController,
              hasError: passwordError || state.passwordError,
              showPasswordToggle: true,
              onChanged: (value) {
                setState(() {
                  // Kullanıcı yazmaya başladığında kırmızı hatayı kaldır
                  passwordError = false;
                });
                cubit.passwordChanged(value);
              },
              hinttext: "Password".tr(),
              lenght: 20,
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                child: Text(
                  "Forgot Password".tr(),
                  style: context.theme.textTheme.bodySmall?.copyWith(
                    fontFamily: AppFontFamilies.instrumentSansSemiBold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(
              width: 100.w,
              child: CustomFilledButton(
                text: "Giriş Yap".tr(),
                onPressed: () async {
                  setState(() {
                    emailError = !emailController.text.contains('@');
                    passwordError = passwordController.text.isEmpty;
                  });

                  if (emailError || passwordError) return;

                  // Backend login
                  await cubit.login();

                  // Eğer backend hata dönerse TextField hatalarını göster
                  if (cubit.state.error != null) {
                    setState(() {
                      emailError = true;
                      passwordError = true;
                    });
                  }
                },
              ),
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
            "Don't have an account?".tr(),
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
              NavigationService().navigateTo('/register');
            },
            child: Text("Register".tr(), style: context.textTheme.bodySmall),
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
