import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/constants/app_icons.dart';
import 'package:shartflix_movie_app_case/view/app/controller/controller_screen.dart';
import 'package:shartflix_movie_app_case/widgets/filled_button.dart';
import 'package:shartflix_movie_app_case/widgets/shadow_effect.dart';

class AddPhotoScreen extends StatelessWidget {
  const AddPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    middleArea(context),
                    bottomButtons(context),
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
            onTap: () => Navigator.pop(context),
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
          child: Text(
            "Profil Detayı",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  // *** BOTTOM BUTTONS ***
  Column bottomButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: 15,
      children: [
        SizedBox(
          width: 100.w,
          child: CustomFilledButton(text: "Devam Et", onPressed: () {}),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => const ControllerScreen()),
          ),
          child: SizedBox(
            width: 100.w,

            child: Text(
              "Atla",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  // *** MIDDLE AREA EXPANDED ***
  Expanded middleArea(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 5,
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withAlpha(50),
              borderRadius: BorderRadius.circular(24),
            ),
            child: AppIcons.icon(
              AppIcons.profileFill,
              color: Color(0xFFF8C6C6),
            ),
          ),
          Text("Fotoğraf Yükle", style: Theme.of(context).textTheme.bodyLarge),
          Text(
            "Profil fotoğrafın için görsel yükleyebilirsin",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 20),
          CustomPaint(
            painter: _DashedBorderPainter(),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).cardColor.withAlpha(100),
              ),
              child: Center(child: AppIcons.icon(AppIcons.plus)),
            ),
          ),
        ],
      ),
    );
  }
}

// *** ÇİZGİLİ BORDERLAR ***
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
