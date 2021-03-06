import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:welcome2/common/theme_helper.dart';
import 'package:welcome2/pages/Homepage.dart';
import 'package:welcome2/pages/welcome.dart';

import 'package:welcome2/pages/profile_page.dart';

import 'forgot_password.dart';
import 'package:provider/provider.dart';
import 'sign_up.dart';
import '../widgets/header_widget.dart';
import 'package:localstorage/localstorage.dart';
import 'package:welcome2/api/host.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 300;
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _password;
  void test() async {
    print('button pressed');
  }

  Future loginNow(String username, String password) async {
    LocalStorage storage = LocalStorage("usertoken");
    print(username);
    print(password);
    // try {
    final url = Uri.parse(host + '/apis/login/');
    http.Response response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );
    var data = json.decode(response.body) as Map;
    if (data.containsKey('token')) {
      storage.setItem('token', data['token']);
      storage.setItem('username', username);
      return true;
    }
    return false;
    // } catch (e) {
    //   return false;
    // }
  }

  void _loginnow() async {
    print('button pressed');
    var isvalid = _formKey.currentState.validate();
    if (!isvalid) {
      return;
    }
    _formKey.currentState.save();
    print(_formKey.toString());
    bool islogin = await loginNow(_username, _password);
    print(islogin);
    if (islogin) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Nom D'utilisateur ou Mot de passe incorrect!"),
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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: Header(
                _headerHeight,
              ), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      Text(
                        'Se connecter',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30.0),

                      //nom utiliateur
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextField(
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Nom utilisateur', 'Entrer votre nom'),
                                  onChanged: (v) {
                                    _username = v;
                                  },
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),

                              SizedBox(height: 30.0),
                              //mot de passe
                              Container(
                                child: TextField(
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Mot de passe',
                                      'Entrer votre mot de passe'),
                                  onChanged: (v) {
                                    _password = v;
                                  },
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 15.0),
                              //button
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPasswordPage()),
                                    );
                                  },
                                  //text mot de passe oubli??
                                  child: Text(
                                    "Mot de passe oubli???",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'Go !'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {
                                    // print('button pressed');
                                    //After successful login we will redirect to profile page. Let's create profile page now
                                    _loginnow();
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => Homepage()));
                                    // test();
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(text: "Pas encore de compte? "),
                                  TextSpan(
                                    text: ' Cr??er ',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegistrationPage()));
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 247, 149, 22)),
                                  ),
                                ])),
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
