import 'package:flutter/material.dart';

import '../themes/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.icon,
    this.maxLine = 1,
    this.onTap,
  });

  final hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final obscureText;
  final icon;
  final onTap;
  final maxLine;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      validator: (value) {
        value!.isEmpty ? '$hint is Required' : null;
      },
      style: TextStyle(
        fontFamily: 'en_font',
        fontSize: 16,
        color: Colors.white,
      ),
      onTap: onTap,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: 'en_font',
          color: Colors.white,
        ),
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: Colors.white,
              )
            : null,
        filled: true,
        fillColor: AppColors.primaryGreyColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
