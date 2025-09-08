import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix_movie_app_case/bloc/theme_cubit.dart';
import 'package:shartflix_movie_app_case/core/constants/strings.dart';
import 'package:shartflix_movie_app_case/core/extensions/padding_extension.dart';
import 'package:shartflix_movie_app_case/core/services/navigation_service.dart';
import 'package:shartflix_movie_app_case/core/widgets/outlined_container.dart';
import 'package:shartflix_movie_app_case/core/widgets/shaderMaskWidget.dart';
import 'package:shartflix_movie_app_case/core/widgets/shadow_effect.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppBackground.lightEffect(highLight: false),
          SafeArea(
            child: Padding(
              padding: context.paddingMedium,
              child: Column(
                spacing: 50,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerTtile(context),
                  settings(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // *** HEADER BAŞLIK ***
  Padding headerTtile(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => NavigationService().goBack(),
                        child: Icon(Icons.keyboard_backspace_sharp, size: 30),
                      ),
                      shaderMaskWidget(
                        context,
                        Text(
                          "AYARLAR",
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                fontFamily: AppFontFamilies.plusJakartaSans,
                                color: Theme.of(context).shadowColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                );
  }

  // *** SETTINGS LIST ***
  Expanded settings(BuildContext context) {
    return Expanded(
                  child: ListView(
                    
                    children: [
                      _buildSettingsTile(
                        context,
                        icon: Icons.invert_colors_outlined,
                        title: "Tema",
                        subtitle: "Göz yorgunluğunu önler",
                        trailing: BlocBuilder<ThemeCubit, ThemeMode>(
                          builder: (context, themeMode) {
                            return CupertinoSwitch(
                              value: themeMode == ThemeMode.dark,
                              onChanged: (_) {
                                context.read<ThemeCubit>().toggleTheme();
                              },
                            );
                          },
                        ),
                        onTap: () {
                          context.read<ThemeCubit>().toggleTheme();
                        },
                      ),
                      SizedBox(height: 10),
                      _buildSettingsTile(
                        context,
                        icon: Icons.text_fields_rounded,
                        title: "Dil",
                        subtitle: "Türkçe/İngilizce",
                        trailing: BlocBuilder<ThemeCubit, ThemeMode>(
                          builder: (context, themeMode) {
                            return CupertinoSwitch(
                              value: false,
                              onChanged: (_) {
                                
                              },
                            );
                          },
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                );
  }

  // *** SETTING MODEL ***
  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    return outlinedContainer(
      context,
      ListTile(
        splashColor: Colors.transparent,
        leading: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).shadowColor.withAlpha(50),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon),
        ),
        title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).shadowColor.withAlpha(100),
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
