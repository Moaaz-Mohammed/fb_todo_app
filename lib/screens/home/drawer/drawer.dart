import 'package:fb_todo_app/screens/home/home_screen.dart';
import 'package:fb_todo_app/shared/constants.dart';
import 'package:fb_todo_app/shared/widgets/drawer_tile_widget.dart';
import 'package:fb_todo_app/shared/widgets/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../shared/functions.dart';
import '../../../shared/themes/colors.dart';
import '../../auth/signin_screen.dart';
import '../../categories/enter_tasks_screen.dart';
import '../../categories/health_tasks_screen.dart';
import '../../categories/ideas_tasks_screen.dart';
import '../../categories/important_tasks_screen.dart';
import '../../categories/shopping_tasks_screen.dart';
import '../../categories/study_tasks_screen.dart';
import '../../categories/vacation_tasks_screen.dart';
import '../../categories/work_tasks_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    required this.userData,
  }) : super(key: key);
  final userData;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.only(top: 60, right: 20),
      height: height,
      decoration: BoxDecoration(
        gradient: Constants.linearGradient,
      ),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
                top: 5,
                right: 0,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 30,
                    color: Colors.white,
                  ),
                )),
            Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      userData['userName'],
                      style: const TextStyle(
                        fontFamily: 'en_font',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      userData['userEmail'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w200,
                        fontFamily: 'en_font',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 40,
                  color: AppColors.primaryGreyColor,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 15),
                //   child: ListTileTheme(
                //     contentPadding: const EdgeInsets.all(0),
                //     horizontalTitleGap: 15.0,
                //     minLeadingWidth: 0,
                //     child: ExpansionTile(
                //       iconColor: Colors.white,
                //       collapsedIconColor: Colors.white,
                //       leading: const Icon(
                //         Icons.grid_3x3_outlined,
                //         color: Colors.white,
                //         size: 30,
                //       ),
                //       title: const Text(
                //         'Categories',
                //         style: const TextStyle(
                //           fontFamily: 'en_font',
                //           fontSize: 16,
                //           color: Colors.white,
                //         ),
                //       ),
                //       children: [],
                //     ),
                //   ),
                // ),
                DrawerTileWidget(
                  icon: Icons.star_border_outlined,
                  title: 'Important',
                  screen: ImportantTasksScreen(),
                ),
                DrawerTileWidget(
                  icon: Icons.work_outline,
                  title: 'Work',
                  screen: WorkTasksScreen(),
                ),
                DrawerTileWidget(
                  icon: Icons.health_and_safety_outlined,
                  title: 'Health',
                  screen: HealthTasksScreen(),
                ),
                DrawerTileWidget(
                  icon: Icons.travel_explore,
                  title: 'Vacation',
                  screen: VacationTasksScreen(),
                ),
                DrawerTileWidget(
                  icon: Icons.tips_and_updates_outlined,
                  title: 'Ideas',
                  screen: IdeasTasksScreen(),
                ),
                DrawerTileWidget(
                  icon: Icons.movie_creation_outlined,
                  title: 'Entertainment',
                  screen: EntertainmentTasksScreen(),
                ),
                DrawerTileWidget(
                  icon: Icons.sticky_note_2,
                  title: 'Study',
                  screen: StudyTasksScreen(),
                ),
                DrawerTileWidget(
                  icon: Icons.note,
                  title: 'Shopping',
                  screen: ShoppingTasksScreen(),
                ),
                DrawerTileWidget(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  screen: HomeScreen(),
                ),
                InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Functions.navigatorPushAndRemove(
                        context: context,
                        screen: SignInScreen(),
                      );
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 15, bottom: 5),
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        TitleText(
                          text: 'Logout',
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
