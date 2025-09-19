import 'package:emojis_demo/welcome_page.dart';
import 'package:emojis_demo/util/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
      theme: theme,
      home:WelcomePage()
    );
  }
}

