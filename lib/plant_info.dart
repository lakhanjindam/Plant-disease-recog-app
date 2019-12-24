import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class get_info extends StatelessWidget {
  String plant_name;

  get_info(this.plant_name);

  String assetload;

  setasset() {
    if (plant_name == "Apple") {
      assetload = "assets/apple.json";
    } else if (plant_name == "Grapes") {
      assetload = "assets/grapes.json";
    } else if (plant_name == "Peach") {
      assetload = "assets/peach.json";
    } else {
      assetload = "assets/tomato.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    // this function is called before the build so that
    // the string assetload is avialable to the DefaultAssetBuilder
    setasset();
    // and now we return the FutureBuilder to load and decode JSON
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(assetload, cache: true),
      builder: (context, snapshot) {
        //import convert package from dart for encoding and decoding
        List mydata = json.decode(snapshot.data.toString());
        if (mydata == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Loading",
              ),
            ),
          );
        } else {
          //calls the below class
          return plantpage(mydata: mydata);
        }
      },
    );
  }
}

class plantpage extends StatefulWidget {
  var mydata;

  //adding data to the parameters of plant page.
  plantpage({Key key, @required this.mydata}) : super(key: key);

  @override
  _plantpageState createState() => _plantpageState(mydata);
}

class _plantpageState extends State<plantpage> {
  var mydata;

  _plantpageState(this.mydata);

  /*
  String imageload;
  setimage(){
    if (plant_image=="Python"){
      imageload = "images/py.png";
    }else if (plant_image=="Linux"){
      imageload = "images/linux.png";
    }

  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("info"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("/plants");
          },
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                height: 30,
                width: 130,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.black,
                  gradient: new LinearGradient(
                    colors: [Colors.red, Colors.redAccent],
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Description :",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: "satisfy",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Flexible(
                flex: 3,
                child: Container(
                  color: Colors.white,
                  child: Text(
                    mydata[0][1.toString()],
                    style: TextStyle(
                      fontFamily: "Quando",
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 30,
                width: 120,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [Colors.red, Colors.deepOrangeAccent],
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Fertilizers :",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: "Satisfy",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Flexible(
                flex: 3,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    //place the text at the start of the column i.e to extreme left
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        mydata[1][1.toString()],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Quando",
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        mydata[1][2.toString()],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Quando",
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        mydata[1][3.toString()],
                        style: TextStyle(
                          fontFamily: "Quando",
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 180,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.black,
                  gradient: new LinearGradient(
                    colors: [Colors.red, Colors.deepOrangeAccent],
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Types of diseases :",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: "Satisfy",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.white,
                child: Column(
                  //place the text at the start of the column i.e to extreme left
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      mydata[2][1.toString()],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "Quando",
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 30,
                width: 130,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.black,
                  gradient: new LinearGradient(
                    colors: [Colors.red, Colors.redAccent],
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Pesticides  :",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: "satisfy",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.white,
                child: Column(
                  //place the text at the start of the column i.e to extreme left
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      mydata[3][1.toString()],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "Quando",
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
