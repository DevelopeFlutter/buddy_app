import 'package:buddy_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String fieldType;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.fieldType,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textBaseline: TextBaseline.ideographic,
      children: [
        Text(
          fieldType,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: AppTextStyles.arialUniCodeMs,
          ),
        ),
        SizedBox(
          height: 70,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center, 
            controller: controller,
            obscureText: obscureText,
            obscuringCharacter: '*',
            validator: validator,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8), 
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                height: 0.0, 
                fontSize: 18, 
                fontFamily: AppTextStyles.arialUniCodeMs,
                color: Colors.grey.shade400,
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
