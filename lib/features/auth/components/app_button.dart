import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
 final  TextStyle style;
  final void Function()? onTap;
   const AppButton(
      {super.key,
      required this.onTap,
      required this.text,
      required this.height,
      required this.width,
       required this.style,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: style
        ),
      ),
    );
  }
}
