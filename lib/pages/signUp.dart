import 'package:flutter/material.dart';
import 'package:tp_api/models/userModel.dart';
import 'package:tp_api/service/ConnexionCtroleur.dart';

import '../service/wrapper.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  BuildContext? ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldMessengerState>();
  String? name, _username, _password, surname, tel;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    var loginBtn = new TextButton(
      onPressed: _submit,
      child: new Text("s'inscrire"),
    );

    var loginForm = new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(
            "Inscription",
            textScaleFactor: 2.0,
          ),
          new Form(
            key: formKey,
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new TextFormField(
                    onSaved: (val) => name = val,
                    decoration: new InputDecoration(labelText: "Nom"),
                  ),
                ),
                new Form(
                  key: formKey,
                  child: new Column(
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new TextFormField(
                          onSaved: (val) => surname = val,
                          decoration: new InputDecoration(labelText: "Prenom"),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new TextFormField(
                          onSaved: (val) => tel = val,
                          decoration:
                              new InputDecoration(labelText: "Telephone"),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new TextFormField(
                          onSaved: (val) => _password = val,
                          decoration:
                              new InputDecoration(labelText: "Password"),
                        ),
                      )
                    ],
                  ),
                ),
                loginBtn
              ],
            ),
          )
        ]);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Inscription"),
      ),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        ?.showSnackBar(new SnackBar(content: new Text(text)));
  }

  void _submit() {
    final form = formKey.currentState;

    if (form!.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        var user = new UserModel(name!, surname!, tel!, _username!, _password!);
        var db = new ConnexionCtr();
        db.saveUser(user);
        _isLoading = false;
        Navigator.of(context).pushNamed("/login");
      });
    }
  }
}
