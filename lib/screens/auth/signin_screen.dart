import 'package:fb_todo_app/screens/auth/signup_screen.dart';
import 'package:fb_todo_app/shared/functions.dart';
import 'package:fb_todo_app/shared/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/constants.dart';
import '../../shared/themes/colors.dart';
import '../../shared/widgets/custom_button.dart';
import '../../state_management/bloc/cubit.dart';
import '../../state_management/bloc/states.dart';
import 'auth.dart';
import 'reset_password_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final auth = Auth();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
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
                        'Hello,',
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
                        height: height * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primaryGreyColor,
                        ),
                        child: Form(
                          key: globalKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    Functions.navigatorPush(
                                      context: context,
                                      screen: ResetPasswordScreen(),
                                    );
                                  },
                                  child: Text(
                                    'Forgot your password?',
                                    style: TextStyle(
                                      fontFamily: 'en_font',
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Center(
                                  child: CustomButton(
                                title: 'Login',
                                onTap: () async {
                                  if (globalKey.currentState!.validate()) {
                                    await auth.signInWithEmailAndPassword(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      context: context,
                                    );
                                  }
                                },
                              )),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Don\'t have an account?',
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
                                    onTap: () {
                                      Functions.navigatorPush(
                                        context: context,
                                        screen: SignUpScreen(),
                                      );
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                        fontFamily: 'en_font',
                                        fontSize: 16,
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
