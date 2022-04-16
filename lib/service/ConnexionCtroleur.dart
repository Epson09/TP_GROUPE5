import 'package:tp_api/models/userModel.dart';
import 'package:tp_api/service/wrapper.dart';

class ConnexionCtr {
  DatabaseHelper con = new DatabaseHelper(); //insertion

  Future<int> saveUser(UserModel user) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  } //deletion

  Future<int> deleteUser(UserModel user) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("User");
    return res;
  }

  Future<UserModel?> getLogin(String user, String password) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM user WHERE username = '$user' and password = '$password'");

    if (res.length > 0) {
      return new UserModel.fromMap(res.first);
    }
    return null;
  }

  Future<List<UserModel>> getAllUser() async {
    var dbClient = await con.db;
    var res = await dbClient.query("user");
    List<UserModel>? list =
        res.isNotEmpty ? res.map((c) => UserModel.fromMap(c)).toList() : null;
    return list!;
  }
}
