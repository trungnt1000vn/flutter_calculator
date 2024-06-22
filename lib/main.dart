import 'package:flutter/material.dart';
import 'package:flutter_calculator/calculatorscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: CalculatorScreen(),
    );
  }
}