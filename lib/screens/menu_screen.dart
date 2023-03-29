import 'package:Calculator/components/app_bar.dart';
import 'package:Calculator/screens/calculator_screen.dart';
import 'package:flutter/material.dart';

import 'calc.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);
  static const String id = 'menu_screen';

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Color topColor = Colors.blueGrey;
  Color bottomColor = Colors.lightGreenAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [topColor, bottomColor]),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(padding: EdgeInsets.only(top: 50)),
              SizedBox(
                height: 32,
                width: double.infinity,
              ),
              ElevatedButton(
                child: Text(
                  'Go To Calculator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Calc.id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
