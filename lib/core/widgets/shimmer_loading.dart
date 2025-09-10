import 'package:flutter/material.dart';
import 'package:shartflix_movie_app_case/core/extensions/theme_extension.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerLoading extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ShimmerLoading({
    Key? key,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: Shimmer(
        duration: const Duration(seconds: 1),
        color: context.theme.shadowColor,
        child: SizedBox(
          width: width,
          height: height,
          child: Container(
            color: context.theme.primaryColor.withAlpha(50),
          ),
        ),
      ),
    );
  }
}
