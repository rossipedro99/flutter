import 'dart:convert';

import 'package:Calculator/components/app_bar.dart';
import 'package:Calculator/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/utilities.dart';
import '../models/sign_up_service.dart';
import '../models/user.dart';
import '../values/preferences_keys.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const String id = "sign_up_screen";

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  Color topColor = Colors.blueGrey;
  Color bottomColor = Colors.lightGreenAccent;
  bool showPassword = false;
  bool _isLoading = false;
  TextEditingController _nameInputController = TextEditingController();
  TextEditingController _emailInputController = TextEditingController();
  TextEditingController _passswordInputController = TextEditingController();
  TextEditingController _confirmPasswordInputController =
  TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
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
            children: [
              SizedBox(
                height: 12,
                width: double.infinity,
              ),
              Text(
                "Register",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 16)),
              Form(
                key: _formKey,
                child: (_isLoading) ? CircularProgressIndicator() :
                Column(
                  children: [
                    TextFormField(
                      validator: _nameCheck,
                      controller: _nameInputController,
                      decoration: InputDecoration(
                        labelText: 'Nome Completo',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: _emailCheck,
                      controller: _emailInputController,
                      decoration: InputDecoration(
                        labelText: 'E-Mail',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: Colors.white,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: _passwordCheck,
                      controller: _passswordInputController,
                      obscureText: (showPassword == true) ? false : true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefixIcon: Icon(
                          Icons.key,
                          color: Colors.white,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: _confirmPasswordCheck,
                      controller: _confirmPasswordInputController,
                      obscureText: (showPassword == true) ? false : true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefixIcon: Icon(
                          Icons.key,
                          color: Colors.white,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 12)),
                    Row(
                      children: [
                        Checkbox(
                          value: showPassword,
                          onChanged: (var newValue) {
                            setState(() {
                              showPassword = newValue!;
                              print(showPassword);
                            });
                          },
                        ),
                        Text(
                          'Show Passwords?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 32)),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          _doSignUp();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),)
      ,
    );
  }

  void _doSignUp() async {
    if (_formKey.currentState?.validate() == true) {
      String _emailForm = _emailInputController.text;
      String _passForm = _passswordInputController.text;
      String _name = _nameInputController.text;

      setState(() {
        this._isLoading = true;
      });

      dynamic signUpResponse = await SignUpService().signUp(
        _emailForm,
        _passForm,
        _name,
      );
      await SignUpService().saveOnRealTimeDatabase(_name, _emailForm);
      print("SignupResponse " + signUpResponse['mensagem']);
      if (signUpResponse['sucesso']) {
        Utilities.message(context, signUpResponse['mensagem']);
        Navigator.pushReplacementNamed(context, LoginScreen.id);
        setState(() {
          this._isLoading = false;
        });
        return;
      } else {
        Utilities.message(context, signUpResponse['mensagem']);
        setState(() {
          this._isLoading = false;
        });
      }
    }
  }

  void _saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      PreferencesKeys.activeUser,
      json.encode(user.toJson()),
    );
  }

  String? _emailCheck(String? value) {
    String email = value ?? "";
    RegExp regexEmail = RegExp(r"^\w+((-\w+)|(\.\w+))*\@\w+((\.|-)\w+)*\.\w+$");

    if (regexEmail
        .allMatches(email)
        .isEmpty) {
      return "Informe um e-mail válido";
    }

    return null;
  }

  String? _passwordCheck(String? value) {
    String senha = value ?? "";

    if (senha.length < 8) {
      return "A senha deve ter ao menos 8 caracteres";
    }

    RegExp regexContemNumero = RegExp(r"\d");
    RegExp regexContemLetraMinuscula = RegExp(r"[a-z]");
    RegExp regexContemLetraMaiuscula = RegExp(r"[A-Z]");

    if (regexContemNumero
        .allMatches(senha)
        .isEmpty) {
      return "Ao menos um caracter numérico";
    }

    if (regexContemLetraMinuscula
        .allMatches(senha)
        .isEmpty) {
      return "Ao menos uma letra minúscula";
    }

    if (regexContemLetraMaiuscula
        .allMatches(senha)
        .isEmpty) {
      return "Ao menos uma letra maiúscula";
    }

    return null;
  }

  String? _confirmPasswordCheck(String? value) {
    String confirmacaoSenha = value ?? "";

    if (confirmacaoSenha != _passswordInputController.text) {
      return "As senhas estão diferentes";
    }

    return null;
  }

  String? _nameCheck(String? value) {
    String nome = value ?? "";
    RegExp regexNome = RegExp(r"^(\S)+(\s(\S)+)+$");

    if (regexNome
        .allMatches(nome)
        .isEmpty) {
      return "Informe seu nome completo";
    }

    return null;
  }
}
