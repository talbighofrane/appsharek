import 'package:flutter/material.dart';
import 'package:welcome2/model/don.dart';
import 'dart:convert';
import '../widgets/don_list.dart';
import 'package:http/http.dart' as http;
import 'package:welcome2/api/host.dart';

class DonListScreen extends StatefulWidget {
  final List<Don> dons;

  DonListScreen(this.dons);

  @override
  _DonListScreenState createState() => _DonListScreenState();
}

class _DonListScreenState extends State<DonListScreen> {
  List<Don> data = [];
  Future<String> getallDon() async {
    final url = Uri.parse(host + '/apis/don/getall?format=json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var datas = json.decode(response.body) as List;
      if (this.mounted) {
        setState(() {
          this.data = datas.map<Don>((json) => Don.fromJson(json)).toList();
        });
      }
    }
    return "Sucess";
  }

  @override
  Widget build(BuildContext context) {
    this.getallDon();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 243, 229),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 193, 125),
        title: Text(
          'Mes dons',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        child: DonList(this.data),
        padding: EdgeInsets.all(8),
      ),
    );
  }
}
