import 'package:flutter/material.dart';
import 'package:todo/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Bucket',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Apply Roboto Condensed font globally
        fontFamily: 'RobotoCondensed', // Apply RobotoCondensed globally
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 14.0, color: Colors.grey),
          displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
      ),
      home: HomePage(),
    );
  }
}
