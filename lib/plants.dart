import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/plant_info.dart';

class Plant_list extends StatefulWidget {
  @override
  _Plant_listState createState() => _Plant_listState();
}

class _Plant_listState extends State<Plant_list> {
  List<String> images = [
    "images/tomato.jpg",
    "images/peach.jpg",
    "images/grapes.jpg",
    "images/apple.jpg",
  ];

  List<String> des = [
    "Tomato is red in color",
    "Peach is yellow in color",
    "grapes is green in color",
    "Apple is red in color",
  ];

  final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [
        0.1,
        0.4,
        0.5
      ],
      colors: [
        Colors.blue,
        Colors.cyan,
        Colors.cyanAccent,
      ]);

  //creating a custom  card for each plant
  Widget customcard(String plant_name, String image, String des) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            // in changelog 1 we will pass the langname name to ther other widget class
            // this name will be used to open a particular JSON file
            // for a particular language
            builder: (context) => get_info(plant_name),
          ));
        },
        child: Material(
          //color: Color.fromRGBO(20, 20, 120 , 0.1),
          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      // changing from 200 to 150 as to look better
                      height: 150.0,
                      width: 150.0,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    plant_name,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontFamily: "Quando",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    des,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontFamily: "Alike",
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final horizontaldivider = Container(
    height: 1,
    width: 100,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      body: new Container(
        color: Colors.black87,
        child: ListView(
          children: <Widget>[
            //passing json file_name in the function parameters along with images and description
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            customcard("Tomato", images[0], des[0]),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: horizontaldivider,
            ),
            customcard("Peach", images[1], des[1]),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: horizontaldivider,
            ),
            customcard("Grapes", images[2], des[2]),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: horizontaldivider,
            ),
            customcard("Apple", images[3], des[3]),
          ],
        ),
      ),
    );
  }
}
