import 'package:Calculator/screens/calc.dart';
import 'package:Calculator/screens/menu_screen.dart';
import 'package:Calculator/screens/calculator_screen.dart';
import 'package:Calculator/screens/login_screen.dart';
import 'package:Calculator/screens/splash_screen.dart';
import 'package:Calculator/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:Calculator/models/historyitem.dart';
import 'package:hive_flutter/hive_flutter.dart';

// @dart=2.9
void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryItemAdapter());
  await Hive.openBox<HistoryItem>('history');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Project',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        MenuScreen.id: (context) => const MenuScreen(),
        Calc.id: (context) => Calc(),
      },
    );
  }
}
