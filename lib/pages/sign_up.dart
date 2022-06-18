import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:welcome2/common/theme_helper.dart';
import 'package:welcome2/widgets/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:welcome2/pages/login.dart';
import 'package:welcome2/api/host.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'profile_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  double _headerHeight = 300;
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  String prenom;
  String nom;
  String email;
  String tel;
  String mdp;

  Future signupNow() async {
    final url = Uri.parse(host + '/apis/user/');
    http.Response response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        'username': email,
        'password': mdp,
        'email': email,
        'first_name': prenom,
        'last_name': nom,
        'phone': tel,
        'group': 'user'
      }),
    );
    var data = json.decode(response.body) as Map;
    if (data.containsKey('message')) {
      if (data['message'] == "added successfully") {
        return true;
      }
      return false;
    }
    return false;
    // } catch (e) {
    //   return false;
    // }
  }

  void sign_up() async {
    var isvalid = _formKey.currentState.validate();
    if (!isvalid) {
      return;
    }
    _formKey.currentState.save();
    bool isSignup = await signupNow();
    if (isSignup) {
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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Stack(
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
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 195,
                          ),
                          Container(
                            child: TextFormField(
                              decoration: ThemeHelper().textInputDecoration(
                                  'Prénom*', 'Entrer votre prénom'),
                              keyboardType: TextInputType.name,
                              onChanged: (v) {
                                prenom = v;
                              },
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Entrer votre prénom";
                                }
                                return null;
                              },
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: TextFormField(
                              decoration: ThemeHelper().textInputDecoration(
                                  'Nom*', 'Entrer votre nom'),
                              keyboardType: TextInputType.name,
                              onChanged: (v) {
                                nom = v;
                              },
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Entrer votre nom";
                                }
                                return null;
                              },
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 15.0),
                          Container(
                            child: TextFormField(
                              decoration: ThemeHelper().textInputDecoration(
                                  " Adresse E-mail* ",
                                  "Entrer votre adresse-mail"),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (v) {
                                email = v;
                              },
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "champs obligatoire";
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                    .hasMatch(val)) {
                                  return "Entrer une adresse mail valide";
                                }
                                return null;
                              },
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 15.0),
                          Container(
                            child: TextFormField(
                              decoration: ThemeHelper().textInputDecoration(
                                  "Numero de télephone*",
                                  "Entrer  votre numéro de télephone"),
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                tel = v;
                              },
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Entrer  un numéro valide";
                                }
                                return null;
                              },
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 15.0),
                          Container(
                            child: TextFormField(
                              obscureText: true,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Mot de passe*", "Entrer votre mot de passe"),
                              onChanged: (v) {
                                mdp = v;
                              },
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Entrer un mot de passe";
                                }
                                return null;
                              },
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          FormField<bool>(
                            builder: (state) {
                              return Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: checkboxValue,
                                          onChanged: (value) {
                                            setState(() {
                                              checkboxValue = value;
                                              state.didChange(value);
                                            });
                                          }),
                                      Text(
                                        "J'accepte tous les termes et conditions.",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      state.errorText ?? '',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Theme.of(context).errorColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                            validator: (value) {
                              if (!checkboxValue) {
                                return 'Il faut accepter tous les termes et conditions';
                              } else {
                                return null;
                              }
                            },
                          ),
                          Container(
                            decoration:
                                ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  "Se connecter".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  sign_up();
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            "Ou créer un compte via les réseaux sociaux",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: FaIcon(
                                  FontAwesomeIcons.googlePlus,
                                  size: 35,
                                  color: HexColor("#EC2D2F"),
                                ),
                                onTap: () {
                                  setState(() {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ThemeHelper().alartDialog(
                                            "Google Plus",
                                            "You tap on GooglePlus social icon.",
                                            context);
                                      },
                                    );
                                  });
                                },
                              ),
                              SizedBox(
                                width: 30.0,
                              ),
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        width: 5, color: HexColor("#40ABF0")),
                                    color: HexColor("#40ABF0"),
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.twitter,
                                    size: 23,
                                    color: HexColor("#FFFFFF"),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ThemeHelper().alartDialog(
                                            "Twitter",
                                            "You tap on Twitter social icon.",
                                            context);
                                      },
                                    );
                                  });
                                },
                              ),
                              SizedBox(
                                width: 30.0,
                              ),
                              GestureDetector(
                                child: FaIcon(
                                  FontAwesomeIcons.facebook,
                                  size: 35,
                                  color: HexColor("#3E529C"),
                                ),
                                onTap: () {
                                  setState(() {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ThemeHelper().alartDialog(
                                            "Facebook",
                                            "You tap on Facebook social icon.",
                                            context);
                                      },
                                    );
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
