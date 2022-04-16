import 'package:flutter/material.dart';

import 'dart:io';

import 'package:tp_api/models/userModel.dart';
import 'package:tp_api/pages/signUp.dart';
import 'package:tp_api/service/loginResponse.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginCallBack {
  BuildContext? _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scffoldKey = new GlobalKey<ScaffoldMessengerState>();
  String username = "", password = "";
  LoginResponse? _response;
  _LoginScreenState() {
    _response = new LoginResponse(this);
  }
  void submit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _response!.doLogin(username, password);
      });
    }
  }

  void _showSnackBar(String text) {
    scffoldKey.currentState
        ?.showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new TextButton(onPressed: submit, child: new Text("Login"));
    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => username = val!,
                  decoration: new InputDecoration(labelText: "Username"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => password = val!,
                  decoration: new InputDecoration(labelText: "Password"),
                ),
              )
            ],
          ),
        ),
        loginBtn,
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                /*Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => );
                //_showDialog(context);*/
              },
              child: const Text(
                'S\'inscrire',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(183, 94, 171, 56)),
              ),
            ),
          ],
        ),
      ],
    );

    final _usernameController = TextEditingController();
    final _passwordControler = TextEditingController();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login Page"),
      ),
      key: scffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSucces(UserModel user) {
    if (user != null) {
      Navigator.of(context).pushNamed("/home");
    } else {
      // TODO: implement onLoginSuccess
      _showSnackBar("Login Gagal, Silahkan Periksa Login Anda");
      setState(() {
        _isLoading = false;
      });
    }
  }
}
