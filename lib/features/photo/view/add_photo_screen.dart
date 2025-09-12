import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/constants/app_icons.dart';
import 'package:shartflix_movie_app_case/core/constants/strings.dart';
import 'package:shartflix_movie_app_case/core/extensions/padding_extension.dart';
import 'package:shartflix_movie_app_case/core/extensions/theme_extension.dart';
import 'package:shartflix_movie_app_case/core/widgets/filled_button.dart';
import 'package:shartflix_movie_app_case/core/services/navigation_service.dart';
import 'package:shartflix_movie_app_case/core/widgets/shadow_effect.dart';
import 'package:shartflix_movie_app_case/features/photo/viewmodel/userPhoto_cubit.dart';
import 'package:shartflix_movie_app_case/features/photo/viewmodel/userPhoto_state.dart';

class AddPhotoScreen extends StatelessWidget {
  const AddPhotoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final photoCubit = context.read<PhotoCubit>();
    return Scaffold(
      body: Stack(
        children: [
          AppBackground.lightEffect(),
          SafeArea(
            child: Padding(
              padding: context.paddingLarge,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Profil Detayı",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontFamily: AppFontFamilies.instrumentSansSemiBold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  addPhotoArea(photoCubit),
                  buttons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // *** BUTTONS ***
  BlocBuilder<PhotoCubit, PhotoState> buttons() {
    return BlocBuilder<PhotoCubit, PhotoState>(
      builder: (context, state) {
        String? photoUrl;
        if (state is PhotoSuccess) {
          photoUrl = state.user.photoUrl;
        }

        return Column(
          children: [
            SizedBox(
              width: 100.w,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: CustomFilledButton(
                      text: "Devam Et",
                      onPressed: (photoUrl != null && photoUrl.isNotEmpty)
                          ? () {
                              NavigationService().clearStackAndGo(
                                '/controller',
                              );
                            }
                          : () {}, // boş fonksiyon
                    ),
                  ),
                  if (photoUrl == null || photoUrl.isEmpty)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Atla butonu → fotoğraf varsa pasif
            GestureDetector(
              onTap: (photoUrl == null || photoUrl.isEmpty)
                  ? () {
                      NavigationService().clearStackAndGo('/controller');
                    }
                  : null,
              child: SizedBox(
                width: 100.w,
                child: Text(
                  "Atla",
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontFamily: AppFontFamilies.instrumentSansSemiBold,
                    fontWeight: FontWeight.w600,
                    color: (photoUrl == null || photoUrl.isEmpty)
                        ? context.theme.shadowColor
                        : context.theme.shadowColor.withAlpha(50),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // *** ADD PHOTO ***
  BlocBuilder<PhotoCubit, PhotoState> addPhotoArea(PhotoCubit photoCubit) {
    return BlocBuilder<PhotoCubit, PhotoState>(
      builder: (context, state) {
        String? photoUrl;

        if (state is PhotoSuccess) {
          photoUrl = state.user.photoUrl;
        }

        return SizedBox(
          width: 220,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: context.theme.primaryColor.withAlpha(50),
                ),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [Color(0xFFFFFFFFFF), context.theme.primaryColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors
                        .white, // önemli: gradient mask için genelde beyaz kullanılır
                  ),
                ),
              ),
              Text(
                "Fotoğraf Yükle",
                style: context.textTheme.titleLarge?.copyWith(
                  fontFamily: AppFontFamilies.instrumentSansBold,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Profil fotoğrafın için görsel yükleyebilirsin",
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => _pickImage(context, photoCubit),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Container(
                        width: 170,
                        height: 170,
                        color: context.theme.canvasColor.withAlpha(100),
                        child: state is PhotoLoading
                            ? const Center(child: CircularProgressIndicator())
                            : photoUrl != null && photoUrl.isNotEmpty
                            ? Image.network(photoUrl, fit: BoxFit.cover)
                            : CustomPaint(
                                painter: DashedBorderPainter(),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  alignment: Alignment.center,
                                  color: Colors.transparent,
                                  child: AppIcons.icon(AppIcons.plus),
                                ),
                              ),
                      ),
                    ),
                  ),
                  if (photoUrl != null && photoUrl.isNotEmpty) ...[
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        photoCubit.removePhoto();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.5,
                            color: context.theme.shadowColor.withAlpha(100),
                          ),
                        ),
                        child: AppIcons.icon(AppIcons.x),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // *** IMAGE_PCKER ***
  void _pickImage(BuildContext context, PhotoCubit photoCubit) async {
    final picker = ImagePicker();

    // Kullanıcıya seçim yaptır
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text('Galeriden Seç', style: context.textTheme.bodyLarge),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text('Kamera ile Çek', style: context.textTheme.bodyLarge),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );

    if (source != null) {
      final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 70,
      );
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        photoCubit.uploadPhoto(file);
      }
    }
  }
}

// *** ÇİZGİLİ BORDERLAR HAZIR WIDGET ***
class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 4.0;
    const dashSpace = 4.0;
    final paint = Paint()
      ..color = Colors.grey.shade600
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(32)),
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
