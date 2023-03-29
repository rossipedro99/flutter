import 'dart:convert';

import 'package:http/http.dart' as http;
import '../constants/routes.dart';

class SignUpService {
  get bodyJson => null;

  signUp(String email, String password,String name) async {
    var uri = Uri.parse(Routes.urlSignUp);
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
      print("response" + response.statusCode.toString());
      return {
        'sucesso': false,
        'mensagem': retornarMensagemSignUp(bodyJson['error']['message']),
        'idToken': null
      };
    } else {
      var idToken = bodyJson['idToken'];

      return {
        'sucesso': true,
        'mensagem': 'Cadastro realizado com sucesso',
        'idToken': idToken
      };
    }
  }

  saveOnRealTimeDatabase(String name, String email) {
    Uri url = Uri.https(Routes.realTimeBase, "/register.json");
    http.post(
      url,
      body: json.encode(
        {"name": name, "email": email},
      ),
    );
  }

  String retornarMensagemSignUp(String respostaSignUp) {
    print(respostaSignUp);
    switch (respostaSignUp) {
      case 'EMAIL_EXISTS':
        return 'E-mail já cadastrado';
      default:
        return 'Erro ao realizar cadastro';
    }
  }
}
