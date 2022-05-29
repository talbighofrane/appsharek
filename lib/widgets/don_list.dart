import 'package:flutter/material.dart';
import 'package:welcome2/model/don.dart';

class DonList extends StatelessWidget {
  final List<Don> dons;
  

  DonList(this.dons);

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
                    'Don: ${dons[index].device_type}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Description: ${dons[index].description}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Adresse: ${dons[index].address}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Numéro: ${dons[index].phone}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Etat: ${dons[index].etat}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
      itemCount: dons.length,
    );
  }
}
