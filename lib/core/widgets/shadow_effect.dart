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
                  Color(0xFF3F0306).withAlpha(150),
                  Colors.transparent,
                  
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: highLight,
          child: Container(
            width: 100,
            height: 30,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  spreadRadius: 80,
                  blurRadius: 90,
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
