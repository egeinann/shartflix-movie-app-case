import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/constants/app_icons.dart';
import 'package:shartflix_movie_app_case/core/extensions/theme_extension.dart';
import 'package:shartflix_movie_app_case/core/services/navigation_service.dart';
import 'package:shartflix_movie_app_case/core/widgets/filled_button.dart';
import 'package:shartflix_movie_app_case/core/widgets/shadow_effect.dart';
import 'package:shartflix_movie_app_case/features/auth/viewmodel/auth_cubit.dart';
import 'package:shartflix_movie_app_case/features/photo/viewmodel/userPhoto_cubit.dart';
import 'package:shartflix_movie_app_case/features/photo/viewmodel/userPhoto_state.dart';

class AddPhotoScreen extends StatelessWidget {
  final AuthCubit cubit;
  AddPhotoScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    debugPrint("app'e gönderilen name: ${cubit.state.name}");
    debugPrint("app'e gönderilen email: ${cubit.state.email}");
    debugPrint("Cubit state password: ${cubit.state.password}");
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            AppBackground.lightEffect(),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    headerBar(context),
                    middleArea(context, cubit),
                    bottomButtons(context, cubit),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // *** HEADER TITLE ***
  Stack headerBar(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => NavigationService().goBack(),
            child: Container(
              width: 44,
              height: 44,

              decoration: BoxDecoration(
                color: Colors.white.withAlpha(15),
                borderRadius: BorderRadius.circular(
                  16,
                ), // Yuvarlatılmış köşeler
                border: Border.all(
                  color: Colors.white.withAlpha(50), // İnce beyaz kenarlık
                  width: 1.5,
                ),
              ),
              child: AppIcons.icon(AppIcons.arrow),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text("Profil Detayı", style: context.textTheme.bodyLarge),
        ),
      ],
    );
  }

  // *** BOTTOM BUTTONS ***
  Column bottomButtons(BuildContext context, AuthCubit cubit) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      children: [
        SizedBox(
          width: 100.w,
          child: CustomFilledButton(
            text: "Devam Et",
            onPressed: () {
              debugPrint("app'e gönderilen name: ${cubit.state.name}");
              debugPrint("app'e gönderilen email: ${cubit.state.email}");
              debugPrint("app'e gönderilen password: ${cubit.state.password}");
              cubit.register();
              NavigationService().clearStackAndGo('/controller');
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            debugPrint("app'e gönderilen name: ${cubit.state.name}");
            debugPrint("app'e gönderilen email: ${cubit.state.email}");
            debugPrint("Cubit state password: ${cubit.state.password}");
            cubit.register();
            NavigationService().clearStackAndGo('/controller');
          },
          child: SizedBox(
            width: 100.w,

            child: Text(
              "Atla",
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  // *** MIDDLE AREA EXPANDED ***
  Expanded middleArea(BuildContext context, AuthCubit authCubit) {
  return Expanded(
    child: BlocBuilder<PhotoCubit, PhotoState>(
      builder: (context, state) {
        File? localImage;
        String? networkImage;
        bool isLoading = false;

        if (state is PhotoLoading) {
          isLoading = true;
        } else if (state is PhotoSuccess) {
          networkImage = state.user['photoUrl'] as String?;
          localImage = state.localFile;

          // AuthCubit ile güncelle
          authCubit.updatePhotoUrl(networkImage);
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => pickImage(context, authCubit),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 120,
                      height: 120,
                      color: context.theme.cardColor.withAlpha(100),
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : localImage != null
                              ? Image.file(localImage, fit: BoxFit.cover)
                              : networkImage != null && networkImage.isNotEmpty
                                  ? Image.network(networkImage, fit: BoxFit.cover)
                                  : Center(child: AppIcons.icon(AppIcons.plus)),
                    ),
                  ),
                  if (localImage != null)
                    Positioned(
                      top: -10,
                      right: -10,
                      child: GestureDetector(
                        onTap: () {
                          context.read<PhotoCubit>().removeLocalPhoto();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text("Fotoğraf Yükle", style: context.textTheme.bodyLarge),
            Text(
              "Profil fotoğrafın için görsel yükleyebilirsin",
              style: context.textTheme.bodySmall,
            ),
          ],
        );
      },
    ),
  );
}

  void pickImage(BuildContext context, AuthCubit authCubit) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Kamera'),
            onTap: () => Navigator.pop(context, ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Galeriden Seç'),
            onTap: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    );

    if (source != null) {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 70,
      );
      if (pickedFile != null) {
        final file = File(pickedFile.path);

        // AuthCubit state’inden password alıp PhotoCubit’e iletebilirsin
        final password = authCubit.state.password;

        context.read<PhotoCubit>().uploadPhoto(file, password);
      }
    }
  }
}

// *** ÇİZGİLİ BORDERLAR HAZIR WIDGET ***
class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 5.0;
    const dashSpace = 4.0;
    final paint = Paint()
      ..color = Colors.white.withAlpha(50)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(16)),
      );

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final segment = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(segment, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
