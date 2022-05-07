import 'package:fb_todo_app/services/store.dart';
import 'package:fb_todo_app/shared/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../screens/edit_task_screen.dart';
import '../themes/colors.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    Key? key,
    required this.taskId,
    required this.taskTime,
    required this.taskDate,
    required this.taskTitle,
    required this.taskDescription,
    required this.categoryName,
  }) : super(key: key);
  final taskId;
  final taskTime;
  final taskDate;
  final taskTitle;
  final taskDescription;
  final categoryName;
  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Dismissible(
      direction: DismissDirection.horizontal,
      background: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.delete_outline_outlined,
            size: 40,
            color: Colors.white,
          ),
        ),
        width: 50,
        height: height * 0.15,
      ),
      secondaryBackground: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.edit_outlined,
            size: 40,
            color: Colors.white,
          ),
        ),
        width: 50,
        height: height * 0.15,
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          Store()
              .deleteTaskFromCategory(
                  categoryName: categoryName, taskId: taskId)
              .then(
            (value) {
              showTopSnackBar(
                context,
                CustomSnackBar.success(message: 'Deleted Successfully!'),
              );
            },
          );
        }
        if (direction == DismissDirection.endToStart) {
          Functions.navigatorPush(
              context: context,
              screen: EditTaskScreen(
                  category: categoryName,
                  userId: userId,
                  taskId: taskId,
                  taskTitle: taskTitle,
                  taskTime: taskTime,
                  taskDate: taskDate,
                  taskDescription: taskDescription));
        }
      },
      key: Key(taskId),
      child: InkWell(
        onLongPress: () {
          Functions.navigatorPush(
            context: context,
            screen: EditTaskScreen(
              userId: userId,
              category: categoryName,
              taskId: taskId,
              taskTitle: taskTitle,
              taskTime: taskTime,
              taskDescription: taskDescription,
              taskDate: taskDate,
            ),
          );
        },
        child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
            decoration: BoxDecoration(
              color: AppColors.primaryGreyColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        taskTime,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    VerticalDivider(
                      width: 2,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          taskTitle,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: width * 0.65,
                          height: height * 0.09,
                          child: Text(
                            taskDescription,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    taskDate,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

// void dismissItem (
// BuildContext context,
// var id,
// DismissDirection direction
// ){
//   switch (direction) {
//
//     case DismissDirection.endToStart:
//       Store()
//           .deleteTaskFromCategory(
//           categoryName: categoryName, taskId: taskId)
//           .then(
//             (value) {
//           showTopSnackBar(
//             context,
//             CustomSnackBar.success(message: 'Deleted Successfully!'),
//           );
//         },
//       )),
//       break;
//     case DismissDirection.startToEnd:
//       // TODO: Handle this case.
//       break;
//     case DismissDirection.none:
//       // TODO: Handle this case.
//       break;
//   }
// }
