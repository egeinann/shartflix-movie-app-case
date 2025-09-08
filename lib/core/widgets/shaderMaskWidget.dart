import 'package:flutter/material.dart';

Widget shaderMaskWidget(BuildContext context, Widget widget) {
  return ShaderMask(
    shaderCallback: (bounds) {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Theme.of(context).highlightColor, Colors.transparent],
        stops: const [0.3, 0.8],
      ).createShader(Rect.fromLTWH(1, 0, bounds.width, bounds.height));
    },
    blendMode: BlendMode.dstIn,
    child: widget,
  );
}
