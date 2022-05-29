// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:welcome2/pages/Demande.dart';
import 'package:welcome2/pages/Don.dart';

import 'package:welcome2/common/theme_helper.dart';

import '../common/theme_helper.dart';
import 'header_widget.dart';

class HomePa extends StatefulWidget {
  const HomePa({Key key}) : super(key: key);

  @override
  _HomePaState createState() => _HomePaState();
}

class _HomePaState extends State<HomePa> {
  double _headerHeight = 300;
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: _headerHeight,
            child: Header(_headerHeight), //let's create a common header widget
          ),
          Container(
            width: size.width,
            height: size.height * 0.335,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/hommes.png",
                ),
                fit: BoxFit.none,
              ),
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Container(
                decoration: ThemeHelper().buttonBoxDecoration(context),
                child: ElevatedButton(
                  style: ThemeHelper().buttonStyle(),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: Text(
                      'J\'ai un Besoin '.toUpperCase(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    //After successful login we will redirect to profile page.
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Demanded()));
                  },
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: ThemeHelper().buttonBoxDecoration(context),
                child: ElevatedButton(
                  style: ThemeHelper().buttonStyle(),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: Text(
                      'Faire un Don'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    //After successful login we will redirect to profile page. Let's create profile page now
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Dond()));
                  },
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
