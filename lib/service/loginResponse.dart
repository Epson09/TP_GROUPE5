import 'package:tp_api/models/userModel.dart';
import 'package:tp_api/service/loginRequest.dart';

abstract class LoginCallBack {
  void onLoginSucces(UserModel user);
  void onLoginError(String error);
}

class LoginResponse {
  LoginCallBack _callBack;
  LoginRequest loginRequest = new LoginRequest();
  LoginResponse(this._callBack);
  doLogin(String username, String password) {
    loginRequest
        .getLogin(username, password)
        .then((user) => _callBack.onLoginSucces(user!))
        .catchError((onError) => _callBack.onLoginError(onError.toString()));
  }
}
