import 'package:flutter/material.dart';

class AppBackground {
  static Widget lightEffect({bool highLight = true, bool fade = true}) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Visibility(
          visible: fade,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF8D00000).withAlpha(120),
                  Colors.transparent,
                  
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: highLight,
          child: Container(
            width: 80,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 80,
                  blurRadius: 60,
                  offset: Offset(0, -30),
                  color: Color(0xFFFF1B1B),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
