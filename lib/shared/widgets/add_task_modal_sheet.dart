import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_todo_app/models/task_model.dart';
import 'package:fb_todo_app/services/store.dart';
import 'package:fb_todo_app/shared/constants.dart';
import 'package:fb_todo_app/shared/strings.dart';
import 'package:fb_todo_app/shared/widgets/custom_button.dart';
import 'package:fb_todo_app/shared/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddTaskModalSheet extends StatelessWidget {
  const AddTaskModalSheet({
    Key? key,
    required this.titleController,
    required this.descController,
    required this.timeController,
    required this.dateController,
    required this.category,
  }) : super(key: key);
  final titleController;
  final descController;
  final timeController;
  final dateController;
  final category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).viewInsets,
      decoration: BoxDecoration(
        borderRadius: Constants.borderRadius,
        gradient: Constants.linearGradient,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                icon: Icons.short_text_outlined,
                hint: 'Task Title',
                controller: titleController,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                icon: Icons.notes,
                hint: 'Task Description',
                controller: descController,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                icon: Icons.access_time_outlined,
                hint: 'Task Time',
                controller: timeController,
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    timeController.text = value!.format(context).toString();
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                icon: Icons.date_range_outlined,
                hint: 'Task Date',
                controller: dateController,
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  ).then((value) {
                    dateController.text = DateFormat.yMMMd().format(value!);
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                title: 'Add Task',
                onTap: () {
                  var doc = FirebaseFirestore.instance
                      .collection(Strings.usersCollection)
                      .doc(Strings.userId)
                      .collection(Strings.tasksCollection)
                      .doc();
                  Store()
                      .addTask(
                    TaskModel(
                      taskId: doc.id,
                      taskTitle: titleController.text,
                      taskDescription: descController.text,
                      taskTime: timeController.text,
                      taskDate: dateController.text,
                    ),
                    categoryCollection: category,
                  )
                      .then((value) {
                    showTopSnackBar(
                      context,
                      CustomSnackBar.success(message: 'Added Successfully!'),
                    );
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
