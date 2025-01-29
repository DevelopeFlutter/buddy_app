import 'package:buddy_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget{
    final String fieldType;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const AppTextField(
      {super.key,
      required this.fieldType,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textBaseline: TextBaseline.ideographic,
      children: [
        Text(fieldType,style:const TextStyle(  
                fontSize: 14,
               fontWeight: FontWeight.w500
               ,
                fontFamily: AppTextStyles.arialUniCodeMs,
                
                )),
        SizedBox(
          height: 45,
          child: TextField(
          textAlignVertical: TextAlignVertical.center,
            controller: controller,
            obscureText: obscureText,
            obscuringCharacter: '*',
            decoration: InputDecoration(
            
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide:
                      const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide:
                      const BorderSide(color: Colors.transparent),
                ),
              hintText: hintText,
              
              hintStyle: TextStyle(
                height: 0.5,
                fontSize: 24,
                fontFamily: AppTextStyles.arialUniCodeMs,
                color: Colors.grey.shade400
              ),
              fillColor: Colors.blue.withOpacity(0.1),
              filled: true,
            ),
          ),
        ),
      ],
    );
  }
}
