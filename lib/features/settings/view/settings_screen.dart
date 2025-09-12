import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix_movie_app_case/features/settings/viewmodel/language_cubit.dart';
import 'package:shartflix_movie_app_case/features/settings/viewmodel/theme_cubit.dart';
import 'package:shartflix_movie_app_case/core/constants/strings.dart';
import 'package:shartflix_movie_app_case/core/extensions/padding_extension.dart';
import 'package:shartflix_movie_app_case/core/extensions/theme_extension.dart';
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
                children: [headerTtile(context), settings(context)],
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
              "SETTINGS".tr(),
              style: context.textTheme.labelLarge?.copyWith(
                fontFamily: AppFontFamilies.plusJakartaSans,
                color: context.theme.shadowColor,
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
            title: "Theme".tr(),
            subtitle: "Prevents eye fatiguer".tr(),
            trailing: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return CupertinoSwitch(
                  value: context.watch<ThemeCubit>().state == ThemeMode.dark,
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
            title: "Language".tr(),
            subtitle: "Turkish/English".tr(),
            trailing: BlocBuilder<LanguageCubit, Locale>(
              builder: (context, locale) {
                return CupertinoSwitch(
                  value: locale.languageCode == 'tr', // Türkçe ise true
                  onChanged: (_) {
                    final cubit = context.read<LanguageCubit>();
                    // Switch değiştiğinde dili değiştir
                    cubit.changeLanguage(
                      locale.languageCode == 'tr' ? Locale('en') : Locale('tr'),
                      context,
                    );
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
            color: context.theme.shadowColor.withAlpha(50),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon),
        ),
        title: Text(title, style: context.textTheme.bodyLarge),
        subtitle: Text(
          subtitle,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.theme.shadowColor.withAlpha(100),
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
