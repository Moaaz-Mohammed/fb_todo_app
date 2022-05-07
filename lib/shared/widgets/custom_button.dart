import 'package:flutter/material.dart';

import '../themes/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final title;
  final onTap;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width * 0.6,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primaryGreyColor,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 26,
              fontFamily: 'en_font',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
