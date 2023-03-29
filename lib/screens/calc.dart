import 'package:Calculator/provider/calculator_provider.dart';
import 'package:Calculator/screens/calculator.dart';
import 'package:Calculator/screens/history.dart';
import 'package:Calculator/imports.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Calc extends StatelessWidget {
  static const String id = "calculator";


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalculatorProvider>(
      create: (_) => CalculatorProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: AppBarTheme(
            color: backgroundColor,
            elevation: 0.0,
          ),
          textTheme: TextTheme(
            headline3: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            caption: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
              fontSize: 18.0,
            ),
          ),
          colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: yellowColor),
        ),
        routes: {
          '/': (context) => Calculator(),
          '/history': (context) => History(),
        },
      ),
    );
  }
}