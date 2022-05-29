// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:welcome2/model/demande.dart';
import 'dart:convert';
import '../widgets/demandes_list.dart';
import 'package:http/http.dart' as http;
import 'package:welcome2/api/host.dart';

class DemandeListScreen extends StatefulWidget {
  final List<Demande> demandes;

  DemandeListScreen(this.demandes);

  @override
  _DemandeListScreenState createState() => _DemandeListScreenState();
}

class _DemandeListScreenState extends State<DemandeListScreen> {
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

  @override
  Widget build(BuildContext context) {
    this.getallDemande();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 243, 229),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 193, 125),
        title: Text(
          'Mes demandes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        child: DemandeList(this.data),
        padding: EdgeInsets.all(8),
      ),
    );
  }
}
