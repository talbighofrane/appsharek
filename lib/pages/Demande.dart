// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors,

import 'dart:io';

import 'package:flutter/material.dart';

import '../model/demande.dart';
import '../widgets/cheetah_button.dart';
import '../widgets/cheetah_input.dart';
import '../widgets/demandes_list.dart';
import 'listedesdemandes.dart';
import 'package:http/http.dart' as http;
import 'package:welcome2/api/host.dart';
import 'dart:convert';

class Demanded extends StatefulWidget {
  @override
  DemandedState createState() => DemandedState();
}

class DemandedState extends State<Demanded> {
  String _device_type;

  String _university;
  String _ville;
  String _address;
  String _phone;
  String _description;

  static final List<String> items = <String>["Pc", "Smartphone", 'Autres'];
  String value = items.first;

  List<Demande> demandeList = [];

  Future<String> addDemande(Demande demande) async {
    final url = Uri.parse(host + '/apis/demande/getall');
    print(demande.id_user);
    print(demande.device_type);
    print(demande.description);
    print(demande.university);
    print(demande.ville);
    print(demande.address);
    print(demande.phone);
    if (demande.phone.length > 8) print("over");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode({
          'id_user': demande.id_user,
          'device_type': demande.device_type,
          'description': demande.description,
          'university': demande.university,
          'ville': demande.ville,
          'address': demande.address,
          'phone': demande.phone,
          'status': "en attente"
        }));
    print(response.body);
    if (response.statusCode == 201) {
      print('add scusseful');
    }
    ;
    /*setState(() {
      demandeList.add(demande);
    });*/
    /*print(demande.id);
    print(demande.id_user);
    print(demande.device_type);
    print(demande.description);
    print(demande.address);
    print(demande.ville);
    print(demande.phone);*/
  }

  List<Demande> data = [];
  Future<String> getallDemande() async {
    final url = Uri.parse(host + '/apis/demande/getall?format=json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var datas = json.decode(response.body) as List;
      if (this.mounted) {
        setState(() {
          this.data =
              datas.map<Demande>((json) => Demande.fromJson(json)).toList();
        });
      }
    }
    return "Sucess";
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color.fromARGB(255, 254, 243, 229),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 247, 193, 125),
          title: Text(
            "Demande",
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
                  "J'ai un besoin ",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 20),
                buildDropdown(),
                SizedBox(height: 12),
                CheetahInput(
                  labelText: 'Detail du besoin(Caractéristique)',
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
                  labelText: 'Université',
                  onSaved: (String value) {
                    _university = value;
                  },
                ),
                SizedBox(height: 12),
                CheetahInput(
                  labelText: 'Ville',
                  onSaved: (String value) {
                    _ville = value;
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CheetahButton(
                      text: 'Add',
                      onPressed: () {
                        /*print(_device_type);
                        print(_description);
                        print(_university);
                        print(_ville);
                        print(_address);
                        print(_phone);*/
                        if (!_formKey.currentState.validate()) return;

                        _formKey.currentState.save();

                        addDemande(Demande(1, 1, _device_type, _description,
                            _university, _ville, _address, _phone));
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
                                DemandeListScreen(demandeList),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                DemandeList(demandeList),
              ],
            ),
          ),
        ),
      );

  Widget buildDropdown() => Container(
      width: 400,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3.5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          border: Border.all(color: Color.fromARGB(255, 100, 97, 97))),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
        value: value,
        items: items
            .map((item) => DropdownMenuItem<String>(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  value: item,
                ))
            .toList(),
        onChanged: (value) => setState(
          () {
            this.value = value;
          },
        ),
      )));
}
