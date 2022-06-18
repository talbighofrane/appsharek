import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:welcome2/common/theme_helper.dart';

import 'forgot_password_verification_page.dart';
import '../widgets/header_widget.dart';
import 'package:welcome2/pages/login.dart';
import 'package:welcome2/api/host.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String oldpass;
  String newpass;

  Future editPassNow() async {
    LocalStorage storage = LocalStorage("usertoken");
    print(storage.getItem('username'));
    print(oldpass);
    print(newpass);
    final url = Uri.parse(host + '/apis/user-profil/');
    http.Response response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        'username': storage.getItem('username'),
        'old_password': oldpass,
        'new_password': newpass,
      }),
    );
    print(response.body);
    var data = json.decode(response.body) as Map;
    if (data.containsKey('message')) {
      if (data['message'] == "password updated") {
        return true;
      }
      return false;
    }
    return false;
  }

  void edit_pass() async {
    var isvalid = _formKey.currentState.validate();
    if (!isvalid) {
      return;
    }
    _formKey.currentState.save();
    bool isedited = await editPassNow();
    if (isedited) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Erreur de Saisie! Verifier les champs!"),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _headerHeight,
                child: Header(
                  _headerHeight,
                ),
              ),
              SafeArea(
                top: false,
                child: Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Modifier mot de passe',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              // textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration(
                                    "Mot de passe actuel*",
                                    "Entrer votre mot de passe actuel"),
                                onChanged: (v) {
                                  oldpass = v;
                                },
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Entrer votre mot de passe";
                                  }
                                  return null;
                                },
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              child: TextFormField(
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration(
                                    " Nouveau mot de passe *",
                                    "Entrer nouveau mot de passe "),
                                onChanged: (v) {
                                  newpass = v;
                                },
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Entrer votre mot de passe";
                                  }
                                  return null;
                                },
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              child: TextFormField(
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration(
                                    " Confirmer mot de passe*",
                                    "Entrer nouveau mot de passe "),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Confirmer votre mot de passe";
                                  }
                                  return null;
                                },
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 40.0),
                            Container(
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    "Envoyer".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           ForgotPasswordVerificationPage()),
                                    // );
                                    edit_pass();
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 30.0),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
