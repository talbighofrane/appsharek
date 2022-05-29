// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:welcome2/model/demande.dart';

class DemandeList extends StatelessWidget {
  final List<Demande> demandes;
 

  DemandeList(this.demandes);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Card(
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Besoin: ${demandes[index].device_type}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Description: ${demandes[index].description}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Université: ${demandes[index].university}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Ville: ${demandes[index].ville}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Adresse: ${demandes[index].address}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Numéro: ${demandes[index].phone}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
      itemCount: demandes.length,
    );
  }
}
