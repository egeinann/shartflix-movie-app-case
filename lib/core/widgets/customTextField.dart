import 'package:flutter/material.dart';
import 'package:shartflix_movie_app_case/core/constants/app_icons.dart';
import 'package:shartflix_movie_app_case/core/constants/strings.dart';
import 'package:shartflix_movie_app_case/core/extensions/theme_extension.dart';

class CustomTextField extends StatefulWidget {
  final bool hasError;
  final TextEditingController controller;
  final String hinttext;
  final int lenght;
  final Widget prefixIcon;
  final bool showPasswordToggle;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hasError = false,
    required this.hinttext,
    required this.lenght,
    required this.prefixIcon,

    this.showPasswordToggle = false,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          maxLength: widget.lenght,
          controller: widget.controller,
          style: context.textTheme.bodyMedium?.copyWith(
            color: widget.hasError
                ? const Color(0xFFE50914)
                : context.textTheme.bodyMedium?.color,
          ),
          cursorColor: context.theme.shadowColor,
          cursorHeight: 20,
          onChanged: widget.onChanged,
          obscureText: widget.showPasswordToggle ? _obscureText : false,
          decoration: InputDecoration(
            counterText: "",
            filled: true,
            fillColor: context.theme.cardColor.withAlpha(100),
            hintText: widget.hinttext,
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w400,
              fontFamily: AppFontFamilies.instrumentSansRegular,
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.showPasswordToggle
                ? GestureDetector(
                    child: _obscureText
                        ? AppIcons.icon(AppIcons.hide)
                        : AppIcons.icon(AppIcons.see),
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: Colors.white.withAlpha(20),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: Colors.white.withAlpha(50),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(
                color: Color(0xFFE50914),
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(
                color: Color(0xFFE50914),
                width: 1.5,
              ),
            ),
          ),
        ),
        if (widget.hasError)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 12),
            child: Text(
              "Hatalı giriş. Lütfen Tekrar dene",
              style: context.theme.textTheme.bodySmall?.copyWith(
                color: Color(0xFFF47171),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }
}
