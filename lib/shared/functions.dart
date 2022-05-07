import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Functions {
  static void navigatorPushAndRemove({context, screen}) {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: screen,
      ),
      (route) => false,
    );
  }

  static void navigatorPush({context, screen}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => screen));
  }
}
