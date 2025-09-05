import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomFilledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomFilledButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).highlightColor,
            Theme.of(context).primaryColor,
            
          ], // istediğin gradient renkleri
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          
          overlayColor: Colors.white,
          backgroundColor:
              Colors.transparent,
          shadowColor: Colors.transparent, 
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: Size(25.w, 5.h),
          elevation: 0,
        ),
        child: Text(text, style: Theme.of(context).textTheme.headlineLarge),
      ),
    );
  }
}
