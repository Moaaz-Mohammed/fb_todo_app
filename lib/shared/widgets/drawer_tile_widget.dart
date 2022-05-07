import 'package:fb_todo_app/shared/functions.dart';
import 'package:fb_todo_app/shared/widgets/title_text.dart';
import 'package:flutter/material.dart';

class DrawerTileWidget extends StatelessWidget {
  const DrawerTileWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.screen,
  }) : super(key: key);
  final icon;
  final title;
  final screen;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Functions.navigatorPush(
          context: context,
          screen: screen,
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, bottom: 5),
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
            SizedBox(
              width: 15,
            ),
            TitleText(text: title)
          ],
        ),
      ),
    );
  }
}
