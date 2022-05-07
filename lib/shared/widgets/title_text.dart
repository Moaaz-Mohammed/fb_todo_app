import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontFamily: 'en_font',
        color: Colors.white,
      ),
    );
  }
}
