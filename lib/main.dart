import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/Login_screen.dart';
import 'package:flutter_app_1/shared/styles/bloc_observer.dart';
import 'layout/home_layout.dart';


void main() {
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget
{
  const MyApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark().copyWith(
      //   primaryColor: const Color(0xFF0A0E21),
      //   scaffoldBackgroundColor: const Color(0xFF0A0E21),
      // ),
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomeLayout(),
    );
  }
}