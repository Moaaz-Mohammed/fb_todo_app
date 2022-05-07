import 'package:fb_todo_app/shared/functions.dart';
import 'package:fb_todo_app/shared/widgets/title_text.dart';
import 'package:flutter/material.dart';

class HomeGridWidget extends StatelessWidget {
  const HomeGridWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.screen,
  }) : super(key: key);
  final icon;
  final title;
  final screen;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Functions.navigatorPush(context: context, screen: screen);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white.withOpacity(0.8),
            ),
            Divider(
              color: Colors.white.withOpacity(0.4),
              height: 30,
            ),
            TitleText(text: title)
          ],
        ),
      ),
    );
  }
}
