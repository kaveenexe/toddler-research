import 'package:flutter/material.dart';
import 'package:flutterapp/pages/chat_screen.dart';
import 'package:flutterapp/pages/dangerscissor.dart';
import 'package:flutterapp/pages/dangerknife.dart';

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
      home: const KnifePage(),
    );
  }
}
