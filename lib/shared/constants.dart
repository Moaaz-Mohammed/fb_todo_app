import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static LinearGradient linearGradient = LinearGradient(
    colors: [
      Colors.black,
      Colors.blue,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static BorderRadius borderRadius = BorderRadius.circular(20);
}
