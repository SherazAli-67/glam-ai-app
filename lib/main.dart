import 'package:flutter/material.dart';
import 'package:glam_ai/data/app_data.dart';
import 'package:glam_ai/features/welcome_page.dart';
import 'package:glam_ai/res/app_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: appFontFamilyJakarta
      ),
      home: WelcomePage(images: AppData.aiImages)
    );
  }
}