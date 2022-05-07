import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_todo_app/screens/home/home_screen.dart';
import 'package:fb_todo_app/shared/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../models/task_model.dart';
import '../models/user_model.dart';
import '../shared/functions.dart';

class Store {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Future addTask(
    TaskModel taskModel, {
    required categoryCollection,
  }) async {
    var doc = fireStore
        .collection(Strings.usersCollection)
        .doc(user?.uid)
        .collection(categoryCollection)
        .doc();
    doc.set(
      {
        Strings.taskId: doc.id,
        Strings.taskTitle: taskModel.taskTitle,
        Strings.taskDescription: taskModel.taskDescription,
        Strings.taskTime: taskModel.taskTime,
        Strings.taskDate: taskModel.taskDate,
      },
    );
  }

  /// After Sign in Update User Information In Firebase Firestore
  Future addUser({
    required UserModel userModel,
  }) async {
    fireStore.collection(Strings.usersCollection).doc(userModel.userId).set(
      {
        Strings.userId: userModel.userId,
        Strings.userName: userModel.userName,
        Strings.userEmail: userModel.userEmail,
      },
    );
  }

  /// delete task from category
  Future deleteTaskFromCategory({
    required categoryName,
    required taskId,
  }) async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    fireStore
        .collection(Strings.usersCollection)
        .doc(uid)
        .collection(categoryName)
        .doc(taskId)
        .delete();
  }

  /// edit task data

  Future editTask({
    required taskId,
    required taskTitle,
    required taskDescription,
    required taskTime,
    required taskDate,
    required userId,
    required category,
    required context,
  }) async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    fireStore
        .collection(Strings.usersCollection)
        .doc(uid)
        .collection(category)
        .doc(taskId)
        .update(
      {
        Strings.taskId: taskId,
        Strings.taskTitle: taskTitle,
        Strings.taskDescription: taskDescription,
        Strings.taskTime: taskTime,
        Strings.taskDate: taskDate,
        Strings.userId: userId,
        Strings.categoryName: category,
      },
    ).then(
      (value) {
        Functions.navigatorPushAndRemove(
          context: context,
          screen: HomeScreen(),
        );
        showTopSnackBar(
          context,
          CustomSnackBar.success(message: 'Task data edited successfully!'),
        );
      },
    );
  }
}
