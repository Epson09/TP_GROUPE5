import 'package:tp_api/models/userModel.dart';
import 'package:tp_api/service/ConnexionCtroleur.dart';

class LoginRequest {
  ConnexionCtr conn = new ConnexionCtr();
  Future<UserModel?> getLogin(String username, String password) {
    var result = conn.getLogin(username, password);
    return result;
  }
}
