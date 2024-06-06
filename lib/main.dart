import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculadora/providers/calculadora_provider.dart';
import 'package:calculadora/pages/calculadora_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CalculadoraProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculadoraScreen(),
    );
  }
}
