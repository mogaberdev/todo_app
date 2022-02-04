// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
class ContactMe extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(36, 38, 59, 1.0),
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'Made With ❤ By',
                  style:  TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w200,
                    fontFamily: 'Source Sans Pro',
                    letterSpacing: 2.0,
                  ),
              ),
              SizedBox(height: 30.0,),
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/images/me.jpg'),
              ),
              Text(
                'Mohamed Gaber',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'FLUTTER DEVELOPER',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  color: Colors.white70,
                  fontSize: 20.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.teal.shade100,
                ),
              ),
              Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.add_location,
                      color: Color.fromRGBO(50, 50, 68, 1),
                    ),
                    title: Text(
                      'Alexandria, Egypt',
                      style: TextStyle(
                        color: Color.fromRGBO(50, 50, 68, 1),
                        fontFamily: 'Source Sans Pro',
                        fontSize: 20.0,
                      ),
                    ),
                  )),
              Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Color.fromRGBO(50, 50, 68, 1),
                    ),
                    title: Text(
                      'mogaber811@gmail.com',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromRGBO(50, 50, 68, 1),
                          fontFamily: 'Source Sans Pro'),
                    ),
                  ))
            ],
          )
      ),
    );
  }
}
