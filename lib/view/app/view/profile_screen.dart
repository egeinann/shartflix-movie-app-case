import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix_movie_app_case/bloc/theme_cubit.dart';
import 'package:shartflix_movie_app_case/core/constants/app_icons.dart';
import 'package:shartflix_movie_app_case/core/constants/strings.dart';
import 'package:shartflix_movie_app_case/core/extensions/padding_extension.dart';
import 'package:shartflix_movie_app_case/view/app/widgets/movie_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return CupertinoSwitch(
                  value: themeMode == ThemeMode.dark,
                  onChanged: (_) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                );
              },
            ),
            Padding(
              padding: context.paddingLarge,
              child: Column(
                spacing: 20,
                children: [title(context), profileInformation(context)],
              ),
            ),
            Divider(height: 0.1, color: Color.fromARGB(24, 255, 255, 255)),
            Expanded(
              child: Column(
                children: [MovieWidget(image: "", name: "Aşk Yeniden", title: "Sony")],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // *** TITLE AND CONTAINER ***
  Row title(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Profil",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontFamily: AppFontFamilies.instrumentSansMedium,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(56),

            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFFB2040C), Color(0xFFE50914)],
            ),
          ),
          child: Row(
            spacing: 5,
            children: [
              AppIcons.icon(AppIcons.gem, size: 20, color: Colors.white),
              Text(
                "Sınırlı Teklif",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontFamily: AppFontFamilies.instrumentSansMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // *** PROFIL BILGILERI ***
  Row profileInformation(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).cardColor,

              radius: 30,
              child: AppIcons.icon(AppIcons.profile),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  "Ayça Aydoğan",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFontFamilies.instrumentSansMedium,
                  ),
                ),
                Text(
                  "ID: 245677",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: AppFontFamilies.instrumentSansMedium,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(20),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "Fotoğraf Ekle",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
