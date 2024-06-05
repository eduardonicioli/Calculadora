import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculadora/my_app.dart';
import 'providers/calculadora_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculadoraProvider()),
      ],
      child: MyApp(),
    ),
  );
}
