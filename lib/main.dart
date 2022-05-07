import 'package:fb_todo_app/screens/splash_screen.dart';
import 'package:fb_todo_app/state_management/bloc/cubit.dart';
import 'package:fb_todo_app/state_management/bloc/states.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Todo App',
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
