import 'package:flutter/material.dart';

import '../model/don.dart';
import '../widgets/cheetah_button.dart';
import '../widgets/cheetah_input.dart';
import '../widgets/don_list.dart';
import 'listedon.dart';
import 'package:http/http.dart' as http;
import 'package:welcome2/api/host.dart';
import 'dart:convert';

class Dond extends StatefulWidget {
  @override
  DondState createState() => DondState();
}

class DondState extends State<Dond> {
  String _don;
  String _device_type;
  String _etat;
  String _status;
  String _address;
  String _phone;
  String _description;

  static final List<String> items = <String>["Pc", "Smartphone", 'Autres'];
  String value = items.first;

  List<Don> donList = [];

  Future<String> addDon(Don don) async {
    final url = Uri.parse(host + '/apis/don/getall');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode({
          'id_user': don.id_user,
          'device_type': don.device_type,
          'description': don.description,
          'status': don.status,
          'etat': don.etat,
          'address': don.address,
          'phone': don.phone,
        }));

    if (response.statusCode == 201) {
      print('add scusseful');
    }
    ;
  }

 

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color.fromARGB(255, 254, 243, 229),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 247, 193, 125),
          title: Text(
            "Don",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "J'ai un don ",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 20),
                CheetahInput(
                  labelText: 'Type des appareils',
                  onSaved: (String value) {
                    _device_type = value;
                  },
                ),
                SizedBox(height: 12),
                CheetahInput(
                  labelText: 'Description',
                  onSaved: (String value) {
                    _description = value;
                  },
                ),
                SizedBox(height: 12),
                CheetahInput(
                  labelText: 'Adresse',
                  onSaved: (String value) {
                    _address = value;
                  },
                ),
                SizedBox(height: 12),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Numéro de télèphone',
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if ((val.isEmpty)) {
                        return " Phone number is required";
                      }
                      return null;
                    },
                    onSaved: (String valuee) {
                      _phone = valuee;
                    },
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Etat',
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (val) {
                      if ((val.isEmpty)) {
                        return " Etat is required";
                      }
                      return null;
                    },
                    onSaved: (String valuee) {
                      _etat = valuee;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CheetahButton(
                      text: 'Add',
                      onPressed: () {
                        if (!_formKey.currentState.validate()) return;

                        _formKey.currentState.save();

                        addDon(Don(1, 1, _device_type, _address, _phone,
                            _description, _etat, 'à récupérer'));
                      },
                    ),
                    SizedBox(width: 8),
                    CheetahButton(
                      text: 'List',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DonListScreen(donList),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                DonList(donList),
              ],
            ),
          ),
        ),
      );
}
