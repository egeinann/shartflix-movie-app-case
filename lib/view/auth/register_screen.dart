import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/utils/app_icons.dart';
import 'package:shartflix_movie_app_case/view/auth/login_screen.dart';
import 'package:shartflix_movie_app_case/widgets/checkBox.dart';
import 'package:shartflix_movie_app_case/widgets/customTextField.dart';
import 'package:shartflix_movie_app_case/widgets/filled_button.dart';
import 'package:shartflix_movie_app_case/widgets/shaderMaskWidget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

double opacity = 0.0;
bool isChecked = false;

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _titleAnim;
  late Animation<Offset> _formAnim;
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
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 500),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [title(context), forms(context), footers(context)],
            ),
          ),
        ),
      ),
    );
  }

  // *** FOOTER ***
  SlideTransition footers(BuildContext context) {
    return SlideTransition(
      position: _footerAnim,
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            "Do you already have an account?",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextButton(
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: Text(
              "Back to Login",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // *** FORM ALANI ***
  SlideTransition forms(BuildContext context) {
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
            hinttext: "Full Name",
            lenght: 20,
          ),

          CustomTextField(
            prefixIcon: AppIcons.icon(AppIcons.lock),
            controller: TextEditingController(),
            hasError: true,
            hinttext: "E-mail",
            lenght: 20,
          ),
          CustomTextField(
            prefixIcon: AppIcons.icon(AppIcons.lock),
            controller: TextEditingController(),
            hasError: true,
            hinttext: "Password",
            lenght: 20,
            showPasswordToggle: true,
          ),
          CustomTextField(
            prefixIcon: AppIcons.icon(AppIcons.lock),
            controller: TextEditingController(),
            hasError: true,
            hinttext: "Password Confirmation",
            lenght: 20,
            showPasswordToggle: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
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
              Text(
                "I accept the privacy policy.",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          CustomFilledButton(
            text: "Register",
            onPressed: () {
              isChecked
                  ? print("çalışıyor")
                  : print("çalışmıyor isChecked değeri false");
            },
          ),
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
          "REGISTER",
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontSize: 30.sp),
        ),
      ),
    );
  }
}
