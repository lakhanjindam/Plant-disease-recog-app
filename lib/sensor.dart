import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

class sensordata extends StatefulWidget {
  @override
  _sensordataState createState() => _sensordataState();
}

class _sensordataState extends State<sensordata> {
  var temp;
  var hum;
  var light;
  var moisture;

  bool pressed = false;
  bool on = false;
  bool off = false;
  Color _iconcolor = Colors.black;

  //data is already defined in data.dart file.

  void getdata() async {
    final dbref = FirebaseDatabase.instance.reference();

    // once() function gets the data all at once
    await dbref.once().then((DataSnapshot snapshot) {
      //var keys = snapshot.value.keys;
      var values = snapshot.value;
      temp = values["temperature"];
      hum = values["humidity"];
      moisture = values["soil_moisture"];
      light = values["light_value"];
      /*
      if (values!=null){
        print(values);
      }*/
    });
    setState(() {
      pressed = true; //if this true then only display value
    });

  }

  void refresh() {
    getdata();
  }

  void ondata() {
    final dbref = FirebaseDatabase.instance.reference();
    dbref.update({
      "pump": "ON",
    });
    setState(() {
      on = true;
    });
  }

  void offdata() {
    final dbref = FirebaseDatabase.instance.reference();
    dbref.update({
      "pump": "OFF",
    });
    setState(() {
      off = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sensor data",
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
        backgroundColor: Colors.black,
      ),*/
      body: Container(
        color: Colors.black87,
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.only(left: 10, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.arrowAltCircleLeft,
                        color: Colors.white,
                      ),
                      iconSize: 33,
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.redAccent,
                    ),
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(FontAwesomeIcons.thermometerFull),
                          iconSize: 68,
                          onPressed: () {},
                        ),
                        SizedBox(height: 10),
                        pressed
                            ? Text(
                                temp.toString(),
                                //converting the values to string, cuz it's in integer.
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Qaundo",
                                    fontSize: 20),
                              )
                            : Text(
                                "No value",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Qaundo",
                                    fontSize: 20),
                              ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    color: Colors.white,
                    height: 120,
                  ),
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.purpleAccent,
                    ),
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(FontAwesomeIcons.tint),
                          iconSize: 68,
                          onPressed: () {},
                        ),
                        SizedBox(height: 10),
                        pressed
                            ? Text(
                                hum.toString(),
                                //converting the values to string, cuz it's in integer.
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Qaundo",
                                    fontSize: 20),
                              )
                            : Text(
                                "No value",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Qaundo",
                                    fontSize: 20),
                              ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 1,
                      width: 150,
                      color: Colors.white,
                    ),
                    Container(
                      height: 1,
                      width: 150,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.indigo,
                    ),
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(FontAwesomeIcons.solidSun),
                          iconSize: 68,
                          onPressed: () {},
                        ),
                        SizedBox(height: 10),
                        pressed
                            ? Text(
                                light.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Qaundo",
                                    fontSize: 20),
                              )
                            : Text(
                                "No value",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Qaundo",
                                    fontSize: 20),
                              )
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    color: Colors.white,
                    height: 120,
                  ),
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.pinkAccent,
                    ),
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(FontAwesomeIcons.shower),
                          iconSize: 68,
                          onPressed: () {},
                        ),
                        SizedBox(height: 10),
                        pressed
                            ? Text(
                                moisture.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Qaundo",
                                    fontSize: 20),
                              )
                            : Text(
                                "No value",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Qaundo",
                                    fontSize: 20),
                              )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ButtonTheme(
                    height: 50,
                    minWidth: 50,
                    child: RaisedButton(
                      child: Text("Get values",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Quando",
                          )),
                      color: Colors.black,
                      elevation: 4.0,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(12.0),
                      ),
                      onPressed: () {
                        getdata();
                      },
                    ),
                  ),
                  ButtonTheme(
                    height: 50,
                    minWidth: 50,
                    child: RaisedButton(
                      child: Text(
                        "Refresh",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Quando",
                        ),
                      ),

                      color: Colors.black,
                      elevation: 4.0,
                      textColor: Colors.white,
                      //to round the buttons
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(12.0),
                        /*
                          side: BorderSide(
                              color: Colors.black,
                              width: 5,
                          )*/
                      ),
                      onPressed: () {
                        refresh();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.cloudShowersHeavy,
                      color: _iconcolor,
                    ),
                    onPressed: () {},
                    iconSize: 100,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                alignment: Alignment.center,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: Text("ON"),
                        color: Colors.black,
                        textColor: Colors.white,
                        onPressed: () {
                          ondata();
                          setState(() {
                            _iconcolor = Colors.green;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 20,
                        width: 1,
                        color: Colors.white,

                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FlatButton(
                        child: Text("OFF"),
                        color: Colors.black,
                        textColor: Colors.white,
                        onPressed: () {
                          offdata();
                          setState(() {
                            _iconcolor = Colors.red;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
