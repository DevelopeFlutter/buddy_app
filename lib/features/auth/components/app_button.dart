import 'package:buddy_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
 final String text;

 final void Function()? onTap;
  const AppButton({super.key,required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        height: 42,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.blue,
borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,

child: Text(text,style:  const TextStyle(
color: Colors.white,
fontFamily: AppTextStyles.arialUniCodeMs,
  fontWeight: FontWeight.w500,
  fontSize: 18,
),),
      ),
    );
  }
}