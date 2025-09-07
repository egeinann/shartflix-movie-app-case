import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MovieWidget extends StatelessWidget {
  final String image;
  final String name;
  final String title;

  const MovieWidget({
    super.key,
    required this.title,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5,
      children: [
        Container(
          width: 40.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(image),
        ),
        Text(
          name,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
        title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Color(0xFFFFFFFF).withOpacity(0.5),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
