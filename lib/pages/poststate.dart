import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:localstorage/localstorage.dart';
import 'package:welcome2/api/host.dart';

class PostState with ChangeNotifier {
  LocalStorage storage = LocalStorage("usertoken");

  Future<bool> loginNow(String username, String password) async {
    print("in poststate");
    try {
      final url = Uri.parse(host + '/user/login/');
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
      // print(data);
      if (data.containsKey('token')) {
        storage.setItem('token', data['token']);
        /* final String url = host + '/apis/profile/?token=' + data['token'];
        final response = await http.get(url);
        List<Enseignant> datas = [];
        if (response.statusCode == 200) {
          var datass = json.decode(response.body) as List;
          datas = datass
              .map<Enseignant>((json) => Enseignant.fromJson(json))
              .toList();
          ens = datas[0];
          await storage.setItem('nom', ens.nom);
          await storage.setItem('prenom', ens.prenom);
          await storage.setItem('image', ens.image);
          await storage.setItem('email', ens.email);
        }*/
        // print(storage.getItem('token'));
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
