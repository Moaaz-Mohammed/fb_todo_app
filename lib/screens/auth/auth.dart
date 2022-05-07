import 'package:fb_todo_app/screens/auth/signin_screen.dart';
import 'package:fb_todo_app/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../shared/functions.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  /// method sign up
  Future signUpWithEmailAndPassword(
    String email,
    String password,
    context,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showTopSnackBar(context, CustomSnackBar.error(message: e.toString()));
    } catch (e) {
      showTopSnackBar(context, CustomSnackBar.error(message: e.toString()));
    }
  }

  /// Sign In Method
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required context,
  }) async {
    Center(child: CircularProgressIndicator());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) {
          showTopSnackBar(context,
              CustomSnackBar.success(message: 'LoggedIn Successfully!'));
          Functions.navigatorPushAndRemove(
            context: context,
            screen: SplashScreen(),
          );
        },
      );
      return null;
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showTopSnackBar(context, CustomSnackBar.error(message: e.toString()));
    } catch (e) {
      showTopSnackBar(context, CustomSnackBar.error(message: e.toString()));
    }
  }

  Future signOut({
    required context,
  }) async {
    try {
      return await _auth.signOut().then(
        (value) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(message: 'LoggedOut Successfully!'),
          );
          Functions.navigatorPushAndRemove(
            context: context,
            screen: SignInScreen(),
          );
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
