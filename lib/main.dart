import 'package:flutter/material.dart';
import 'package:flutterapp/pages/Onboarding/onboarding_one.dart';
import 'package:flutterapp/pages/Onboarding/onboarding_two.dart';
import 'package:flutterapp/pages/Onboarding/onboarding_three.dart';
import 'package:flutterapp/pages/Onboarding/onboarding_four.dart';
import 'package:flutterapp/pages/Onboarding/onboarding_screens.dart';
import 'package:flutterapp/pages/SplashScreen/scplash_screen.dart';
import 'package:flutterapp/pages/chat_screen.dart';
import 'package:flutterapp/pages/dangerscissor.dart';
import 'package:flutterapp/pages/dangerknife.dart';
import 'package:flutterapp/pages/toddlerdetailsinput_screen.dart';
import 'package:flutterapp/pages/cry_detection/cry_analyzer.dart';
import 'package:flutterapp/pages/cry_detection/cry_history.dart';
import 'package:flutterapp/pages/cry_detection/cry_recorder.dart';
import 'package:flutterapp/pages/cry_detection/history_display.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFF2F2F2)),
      home: SplashScreen(),
    );
  }
}
