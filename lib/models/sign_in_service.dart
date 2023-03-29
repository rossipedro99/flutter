import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/routes.dart';

class SignInService {
  static final String _key = "key";
  signIn(String email, String password) async {
    var uri = Uri.parse(Routes.urlSignIn);
    http.Response response = await http.post(
      uri,
      body: json.encode(
        {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        },
      ),
    );
    dynamic bodyJson = json.decode(response.body);
    if (response.statusCode == 400) {
      return {
        'sucesso': false,
        'mensagem': retornarMensagem(bodyJson['error']['message']),
        'idToken': null
      };
    } else {
        save(bodyJson['idToken']);
      return {
        'sucesso': true,
        'mensagem': 'Login realizado com sucesso',
        'idToken': bodyJson['idToken']
      };
    }
  }

  String retornarMensagem(String respostaLogin){
    switch(respostaLogin)
    {
      case 'INVALID_EMAIL': return 'Informe um e-mail válido';
      case 'EMAIL_NOT_FOUND': return 'E-mail ou senha inválidos';
      case 'INVALID_PASSWORD': return 'E-mail ou senha inválidos';
      case 'MISSING_PASSWORD': return 'Informe a senha';
      default: return 'Erro ao realizar login';
    }
  }

    static save(String token) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token","token $token");
    print("token $token");
    var teste = prefs.getString(_key);
    print("teste $teste");
     isAuth();
  }

    static Future<bool> isAuth() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonResult = prefs.getString("token");
    print("jsonResult $jsonResult");
    if(jsonResult != null){
      return true;
    }else{
      return false;
    }
  }
}
