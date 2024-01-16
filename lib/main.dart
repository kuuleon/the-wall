import 'package:flutter/material.dart';
import 'package:the_wall/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The wall',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
