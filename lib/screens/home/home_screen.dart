import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_todo_app/screens/categories/enter_tasks_screen.dart';
import 'package:fb_todo_app/screens/categories/important_tasks_screen.dart';
import 'package:fb_todo_app/screens/categories/shopping_tasks_screen.dart';
import 'package:fb_todo_app/screens/categories/study_tasks_screen.dart';
import 'package:fb_todo_app/screens/categories/vacation_tasks_screen.dart';
import 'package:fb_todo_app/screens/categories/work_tasks_screen.dart';
import 'package:fb_todo_app/screens/home/drawer/drawer.dart';
import 'package:fb_todo_app/screens/home/home_grid_widget.dart';
import 'package:fb_todo_app/shared/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../categories/health_tasks_screen.dart';
import '../categories/ideas_tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userAuth;
  var userData;
  void initState() {
    userAuth = FirebaseAuth.instance.currentUser;
    if (userAuth != null) {
      FirebaseFirestore.instance
          .collection(Strings.usersCollection)
          .doc(userAuth!.uid)
          .get()
          .then(
        (value) {
          setState(
            () {
              userData = value.data();
            },
          );
        },
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: height * 0.125, left: width * 0.075),
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.blue,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userData == null
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Hello, ${userData[Strings.userName]}',
                          style: TextStyle(
                            fontFamily: 'en_font',
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 10, right: 15, left: 15, bottom: 10),
                    width: width * 0.85,
                    height: height * 0.75,
                    child: MediaQuery.removeViewPadding(
                      removeTop: true,
                      context: context,
                      child: GridView.count(
                        physics: ClampingScrollPhysics(),
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        crossAxisCount: 2,
                        children: [
                          HomeGridWidget(
                            icon: Icons.star_border_outlined,
                            title: 'Important',
                            screen: ImportantTasksScreen(),
                          ),
                          HomeGridWidget(
                            icon: Icons.work_outline,
                            title: 'Work',
                            screen: WorkTasksScreen(),
                          ),
                          HomeGridWidget(
                            icon: Icons.health_and_safety_outlined,
                            title: 'Health',
                            screen: HealthTasksScreen(),
                          ),
                          HomeGridWidget(
                            icon: Icons.travel_explore,
                            title: 'Vacation',
                            screen: VacationTasksScreen(),
                          ),
                          HomeGridWidget(
                            icon: Icons.tips_and_updates_outlined,
                            title: 'Ideas',
                            screen: IdeasTasksScreen(),
                          ),
                          HomeGridWidget(
                            icon: Icons.movie_outlined,
                            title: 'Entertainment',
                            screen: EntertainmentTasksScreen(),
                          ),
                          HomeGridWidget(
                            icon: Icons.note,
                            title: 'Study',
                            screen: StudyTasksScreen(),
                          ),
                          HomeGridWidget(
                            icon: Icons.shopping_bag_outlined,
                            title: 'Shopping',
                            screen: ShoppingTasksScreen(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(userData: userData),
    );
  }
}
