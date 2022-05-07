import 'package:fb_todo_app/screens/auth/signin_screen.dart';
import 'package:fb_todo_app/shared/constants.dart';
import 'package:fb_todo_app/shared/functions.dart';
import 'package:fb_todo_app/shared/widgets/custom_button.dart';
import 'package:fb_todo_app/shared/widgets/custom_text_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Reset Password',
          style: TextStyle(fontSize: 18, fontFamily: 'en_font'),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: Constants.linearGradient,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reset Password',
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontFamily: 'en_font'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Enter the email associated with your account and we\'ll send an email with a link to reset your password. ',
                style: TextStyle(
                    fontSize: 16, color: Colors.white, fontFamily: 'en_font'),
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                hint: 'E-Mail',
                controller: emailController,
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: CustomButton(
                  title: 'Reset',
                  onTap: () async {
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(
                        email: emailController.text.trim(),
                      )
                          .then(
                        (value) {
                          showTopSnackBar(
                              context,
                              CustomSnackBar.success(
                                  message: 'Sent!, Check your mail 😊'));
                        },
                      ).then(
                        (value) {
                          Functions.navigatorPush(
                            context: context,
                            screen: SignInScreen(),
                          );
                        },
                      );
                    } on FirebaseAuthException catch (error) {
                      showTopSnackBar(
                        context,
                        CustomSnackBar.error(
                          message: error.toString(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
