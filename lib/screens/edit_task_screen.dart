import 'package:fb_todo_app/screens/home/home_screen.dart';
import 'package:fb_todo_app/services/store.dart';
import 'package:fb_todo_app/shared/constants.dart';
import 'package:fb_todo_app/shared/functions.dart';
import 'package:fb_todo_app/shared/widgets/custom_button.dart';
import 'package:fb_todo_app/shared/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({
    Key? key,
    required this.category,
    required this.userId,
    required this.taskId,
    required this.taskTitle,
    required this.taskTime,
    required this.taskDate,
    required this.taskDescription,
  }) : super(key: key);
  final category;
  final userId;
  final taskId;
  final taskTitle;
  final taskTime;
  final taskDate;
  final taskDescription;
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController taskTitleController = TextEditingController();

  TextEditingController taskDescriptionController = TextEditingController();

  TextEditingController taskTimeController = TextEditingController();

  TextEditingController taskDateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data();
  }

  void data() {
    taskTitleController.text = widget.taskTitle;
    taskDescriptionController.text = widget.taskDescription;
    taskTimeController.text = widget.taskTime;
    taskDateController.text = widget.taskDate;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edit : ${widget.taskTitle}',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.all(20),
        height: height,
        decoration: BoxDecoration(
          gradient: Constants.linearGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              CustomTextFormField(
                hint: 'Task Title',
                controller: taskTitleController,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hint: 'Task Description',
                controller: taskDescriptionController,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hint: 'Task Time',
                controller: taskTimeController,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hint: 'Task Date',
                controller: taskDateController,
              ),
              SizedBox(
                height: 30,
              ),
              CustomButton(
                  title: 'Save',
                  onTap: () {
                    Store()
                        .editTask(
                      taskId: widget.taskId,
                      taskTitle: taskTitleController.text,
                      taskDescription: taskDescriptionController.text,
                      taskTime: taskTimeController.text,
                      taskDate: taskDateController.text,
                      userId: widget.userId,
                      category: widget.category,
                      context: context,
                    )
                        .then((value) {
                      showTopSnackBar(context,
                          CustomSnackBar.success(message: 'Changes saved!'));
                    }).then((value) {
                      Functions.navigatorPushAndRemove(
                        context: context,
                        screen: HomeScreen(),
                      );
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
