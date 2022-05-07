import 'package:fb_todo_app/models/user_model.dart';
import 'package:fb_todo_app/screens/auth/signin_screen.dart';
import 'package:fb_todo_app/screens/home/home_screen.dart';
import 'package:fb_todo_app/shared/functions.dart';
import 'package:fb_todo_app/shared/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../services/store.dart';
import '../../shared/constants.dart';
import '../../shared/themes/colors.dart';
import '../../shared/widgets/custom_text_formfield.dart';
import '../../state_management/bloc/cubit.dart';
import '../../state_management/bloc/states.dart';
import 'auth.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final Auth _auth = Auth();
  final Store _store = Store();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  gradient: Constants.linearGradient,
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register,',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: 'en_font',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 40, left: 15, right: 15, bottom: 20),
                        width: width * 0.85,
                        height: height * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primaryGreyColor,
                        ),
                        child: Form(
                          key: globalKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextFormField(
                                  hint: 'Name',
                                  icon: Icons.person_outline_outlined,
                                  controller: usernameController,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomTextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  hint: 'E-Mail',
                                  icon: Icons.email_outlined,
                                  controller: emailController,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomTextFormField(
                                  obscureText: true,
                                  hint: 'Password',
                                  icon: Icons.lock_outlined,
                                  controller: passwordController,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Center(
                                    child: CustomButton(
                                  title: 'Register',
                                  onTap: () async {
                                    if (globalKey.currentState!.validate()) {
                                      await _auth
                                          .signUpWithEmailAndPassword(
                                              emailController.text,
                                              passwordController.text,
                                              context)
                                          .then(
                                        (value) {
                                          User? userAuth =
                                              FirebaseAuth.instance.currentUser;
                                          _store
                                              .addUser(
                                                  userModel: UserModel(
                                            userId: userAuth!.uid,
                                            userName: usernameController.text,
                                            userEmail: emailController.text,
                                          ))
                                              .then(
                                            (value) {
                                              Functions.navigatorPushAndRemove(
                                                context: context,
                                                screen: HomeScreen(),
                                              );
                                              showTopSnackBar(
                                                context,
                                                CustomSnackBar.success(
                                                  message:
                                                      'Account Created Successfully!',
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    }
                                  },
                                )),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Have an account?',
                                      style: TextStyle(
                                        fontFamily: 'en_font',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        Functions.navigatorPush(
                                          context: context,
                                          screen: SignInScreen(),
                                        );
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          fontFamily: 'en_font',
                                          fontSize: 18,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
