import 'package:flutter/material.dart';
import 'package:shawnexchange_interview_app/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: 'Shawn Exchange Interview',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
