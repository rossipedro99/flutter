class Routes{
  static const _baseUrl = "https://identitytoolkit.googleapis.com/v1";
  static const _apiKey = "AIzaSyAxu3P2Y4mTJDws2a9oqqajQIVipJFSK0s";


  static const urlSignUp = "$_baseUrl/accounts:signUp?key=$_apiKey";
  static const urlSignIn = "$_baseUrl/accounts:signInWithPassword?key=$_apiKey";
  static const realTimeBase = "find-the-spy-app-default-rtdb.firebaseio.com";
}