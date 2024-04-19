import 'package:flutter/material.dart';
import 'package:task1/constants.dart';

import 'download_button/presentation/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp
    extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(
      BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

