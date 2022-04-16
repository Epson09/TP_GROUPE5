class UserModel {
  late int _id;
  late String _username;
  late String _password;
  late String _name;
  late String _surname;
  late String _tel;

  //UserModel(this._username, this._password);
  UserModel(
      this._name, this._surname, this._tel, this._username, this._password);

  UserModel.fromMap(dynamic obj) {
    this._username = obj['username'];
    this._password = obj['password'];
    this._name = obj['name'];
    this._surname = obj['surname'];
    this._tel = obj['tel'];
  }

  String get username => _username;
  String get password => _password;
  String get name => _name;
  String get surname => _surname;
  String get tel => _tel;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;
    map["name"] = _name;
    map["surname"] = _surname;
    map["tel"] = _tel;
    return map;
  }
}
