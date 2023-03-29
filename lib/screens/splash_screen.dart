import 'dart:async';

import 'package:Calculator/components/app_bar.dart';
import 'package:Calculator/models/sign_in_service.dart';
import 'package:Calculator/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'menu_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4), () async {
      bool verifyToken = await SignInService.isAuth();

      if (verifyToken) {
        Navigator.pushReplacementNamed(context, MenuScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      }
    });

    //Future.wait([
    //SignInService.isAuth(),
    //]).then((value) => value[0]
    //  ? Navigator.pushReplacementNamed(context, GameMenuScreen.id)
    //: Navigator.pushReplacementNamed(context, LoginScreen.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: CustomAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blueGrey, Colors.lightGreenAccent])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 5,
                width: double.infinity,
              ),
              const Text(
                'Bem Vindo a Calculadora da FIAP',
                style: TextStyle(color: Colors.white70, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 48,
                width: double.infinity,
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
