import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plant_app/plants.dart';
import 'dart:convert';
import 'package:plant_app/prediction.dart';
import 'package:plant_app/sensor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(PlantApp());

class PlantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "disease app",
      debugShowCheckedModeBanner: false,
      home: CameraApp(),

      routes: <String, WidgetBuilder>{
        '/home': (context) => PlantApp(),
        '/plants': (context) => Plant_list(),
        '/sensor': (context) => sensordata(),
      },

    );
  }
}


class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {

  File imagefile; //for storing image file
  String base64;
  List <String> routes = [
    "/plants",
    "/predict",
    "/sensor",
  ];
  //to get the current directory

  /*
  Future<String> get get_Dir async{
    //below function will return directory
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);

  }
*/
  //opening gallery function
  // use async here because selecting image from gallery takes time so wait till user selects the image
  _openGallery(BuildContext context) async{
  var picture  = await ImagePicker.pickImage(source: ImageSource.gallery);
  //updating the state of image
  this.setState((){
    imagefile = picture;
  });
  //after using don't call this again
    Navigator.of(context).pop();
  }

  //opening camera function
  _openCamera(BuildContext context) async{
    var picture  =  await ImagePicker.pickImage(source: ImageSource.camera);
    //updating the state of image

    this.setState((){
      imagefile = picture;
    });
    Navigator.of(context).pop();
  }

  //function For pop-up box on screen
  Future<void> _showChoice(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Select one option"),

        //alert box pop up
        content: SingleChildScrollView(
          child: ListBody(
            //list of items
            children: <Widget>[
              //for gallery part
              GestureDetector(
                child: Text("Gallery"),
                onTap: (){
                  _openGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0),),
              //for camera module
              GestureDetector(
                child: Text("Camera"),
                onTap: (){
                  _openCamera(context);
                },
              )
            ],
          ),
        )
      );
    });
  }
  //for encoding the images to base64

  Future<void> _showAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error!!'),
          content: const Text('No image selected'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  bool selected = false;
  base64_encoder(){
    if (imagefile!=null){
      base64 = base64Encode(imagefile.readAsBytesSync());
      selected= true;
      //print(base64);
    }
  }

  List<String> elem = [
    "Know about plants",
    "Diagnose",
    "Monitor sensors",
  ];
  final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [
        0.1,
        0.7,
        0.3
      ],
      colors: [
        Colors.blue,
        Colors.cyan,
        Colors.cyanAccent,
      ]);

  Widget customCard(String name, String routes) {
    return InkWell(
      onTap: () {
        if(routes=="/predict"){
          base64_encoder();
          if(selected){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => predict(base64),
            ));
          }else if(selected==false){
            _showAlert(context);
          }
        }else{
          Navigator.pushNamed(context, routes);
        }

      },
      child: Container(
        width: 80,
        height: 125,
        decoration: BoxDecoration(
          gradient: gradient,
          //final variable gradient can be used to call design.
          color: Colors.cyanAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: <Widget>[
              Text(
                name,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                FontAwesomeIcons.arrowAltCircleRight,
                color: Colors.black,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body:
          new Container(
            color: Colors.black87,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top:50),
              child: ListView(
                children: <Widget>[
                  customCard(elem[0], routes[0]),
                  new Divider(
                    color: Colors.white,
                    indent: 30,
                    endIndent: 30,
                    height: 20,
                  ),
                  //SizedBox(height: 10),
                  customCard(elem[1], routes[1]),
                  new Divider(
                    color: Colors.white,
                    indent: 30,
                    endIndent: 30,
                    height: 20,
                  ),
                  //SizedBox(height: 10),
                  customCard(elem[2], routes[2]),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.camera),
            backgroundColor: Colors.lightBlue,
            hoverColor: Colors.black,
            onPressed: (){
              _showChoice(context);
            },
          ),

        );
  }
}


