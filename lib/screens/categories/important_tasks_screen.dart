import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_todo_app/shared/constants.dart';
import 'package:fb_todo_app/shared/strings.dart';
import 'package:fb_todo_app/shared/widgets/task_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../shared/widgets/add_task_modal_sheet.dart';

class ImportantTasksScreen extends StatefulWidget {
  ImportantTasksScreen({Key? key}) : super(key: key);

  @override
  State<ImportantTasksScreen> createState() => _ImportantTasksScreenState();
}

class _ImportantTasksScreenState extends State<ImportantTasksScreen> {
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController taskTimeController = TextEditingController();
  TextEditingController taskDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var uid = FirebaseAuth.instance.currentUser?.uid;
    final Stream<QuerySnapshot> _tasksStream = FirebaseFirestore.instance
        .collection(Strings.usersCollection)
        .doc(uid)
        .collection('ImportantTasksCollection')
        .snapshots();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Important Tasks',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'en_font',
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: Constants.linearGradient,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: _tasksStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return TaskCard(
                taskDate: data['taskDate'],
                taskDescription: data['taskDescription'],
                taskTitle: data['taskTitle'],
                taskTime: data['taskTime'],
                taskId: data['taskId'],
                categoryName: Strings.importantTasksCollection,
              );
            }).toList());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            context: context,
            builder: (BuildContext context) => AddTaskModalSheet(
              timeController: taskTimeController,
              descController: taskDescriptionController,
              titleController: taskTitleController,
              dateController: taskDateController,
              category: Strings.importantTasksCollection,
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.black.withOpacity(0.5),
          size: 35,
        ),
      ),
    );
  }
}
