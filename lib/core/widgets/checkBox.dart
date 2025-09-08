import 'package:flutter/material.dart';
import 'package:shartflix_movie_app_case/core/themes/colors.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isSelected;
  final VoidCallback? onTap;

  const CustomCheckBox({super.key, required this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).highlightColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? Theme.of(context).highlightColor : Colors.grey,
            width: 1,
          ),
        ),
        child: isSelected
            ? FittedBox(
                child: const Icon(
                  Icons.check,
                  color: AppColorsLight.background,
                ),
              )
            : null,
      ),
    );
  }
}
