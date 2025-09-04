import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/utils/app_icons.dart';
import 'package:shartflix_movie_app_case/widgets/customTextField.dart';
import 'package:shartflix_movie_app_case/widgets/filled_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus(); // Klavyeyi kapatır
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.red, Colors.transparent],
                  stops: const [0.3, 0.8],
                ).createShader(
                  Rect.fromLTWH(1, 0, bounds.width, bounds.height),
                );
              },
              blendMode: BlendMode.dstIn,
              child: Text(
                "SHARTFLIX",
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontSize: 30.sp),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomTextField(
                  prefixIcon: AppIcons.icon(AppIcons.mail),
                  controller: TextEditingController(),
                  hasError: true,

                  hinttext: "E-mail",
                  lenght: 20,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  prefixIcon: AppIcons.icon(AppIcons.lock),
                  controller: TextEditingController(),
                  hasError: true,
                  hinttext: "Password",
                  lenght: 20,
                ),
                SizedBox(height: 20),
                CustomFilledButton(text: "Login", onPressed: () {}),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Image.asset(AppIcons.apple),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Image.asset(AppIcons.facebook),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Image.asset(AppIcons.google),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Don't have an account?",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ), // splash yok
                    splashFactory: NoSplash.splashFactory,
                    
                  ),
                  onPressed: () {
                  
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
          ],
        ),
      ),
    );
  }
}
