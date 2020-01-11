import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:plant_app/plant_info.dart';

class predict extends StatefulWidget {
  String data;
  File image;

  predict(this.data, this.image);

  @override
  _predictState createState() => _predictState(data, image);
}

class _predictState extends State<predict> {
  String data;
  File image;

  _predictState(this.data, this.image);

  String url = "http://c1f869cf.ngrok.io/predict";
  String resp;
  var isLoading = false;

  //for checking if request is send or not.

  double _Borderradius = 12;
  double _height = 40;
  double _width = 80;
  Color color = Colors.deepOrange;
  Icon icons;
  dynamic element = Text(
    "Predict",
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: "Quando",
    ),
  );

  String plant_name;
  Future<String> getdata() async {
    //shows loading before fetching the data
    setState(() {
      isLoading = true;
    });
    http.Response response = await http
        .post(url, body: {"plant_image": "data:image/jpeg;base64," + data});

    if (response.statusCode == 200) {
      setState(() {
        var res = (json.decode(response.body));
        resp = res["data"];
        //* replaces all "_" with " ".
        resp = resp.replaceAll("_", " ");

        //*stores plant name seperately for dynamic results.
        plant_name = resp;
        resp = "Your plant is diagnosed with: " + plant_name + " disease.";
      });
      //after retrieving the data stops the loading
      setState(() {
        isLoading = false;
        _Borderradius = 40;
        color = Colors.green;

        _height = 70;
        _width = 70;

        // initializing a icon if isloading is false.
        icons = Icon(
          FontAwesomeIcons.check,
          color: Colors.black,
          size: 30,
        );
        element = icons;
      });
    } else if (response.statusCode == 400) {
      resp = "Invalid request!";
      setState(() {
        isLoading = false;
        _Borderradius = 40;
        color = Colors.red;

        _height = 70;
        _width = 70;

        // initializing a icon if isloading is false.
        icons = Icon(
          FontAwesomeIcons.times,
          color: Colors.black,
          size: 30,
        );
        element = icons;
      });
    } else if (response.statusCode == 503) {
      resp = "No internet connection!";
      setState(() {
        isLoading = false;
        _Borderradius = 40;
        color = Colors.red;

        _height = 70;
        _width = 70;

        // initializing a icon if isloading is false.
        icons = Icon(
          FontAwesomeIcons.times,
          color: Colors.black,
          size: 30,
        );
        element = icons;
      });
    } else {
      {
        resp = null;
        if (resp == null) {
          resp = "API Offline!!";
        }
        setState(() {
          isLoading = false;
          _Borderradius = 40;
          color = Colors.red;

          _height = 70;
          _width = 70;

          // initializing a icon if isloading is false.
          icons = Icon(
            FontAwesomeIcons.times,
            color: Colors.black,
            size: 30,
          );
          element = icons;
        });
      }

      print(resp);
    }
  }

  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width, //for auto adjusting the width
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 50),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(FontAwesomeIcons.arrowAltCircleLeft),
                  color: Colors.white,
                  iconSize: 33,
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 250,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(30),
              ),
            
              child: Image.file(
                image,
                fit: BoxFit.cover,
               //use image.file to display image from local file
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
                getdata();
              },
              child: AnimatedContainer(
                height: _height,
                width: _width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(_Borderradius)),
                ),
                duration: Duration(milliseconds: 1500),
                curve: Curves.easeInCirc,
                child: element,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            isLoading ? CircularProgressIndicator() : SizedBox(),
            SizedBox(height: 20),

            ButtonTheme(
              height: 40,
              minWidth: 120,
              child: RaisedButton(
                child: Text(
                  "Show data",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Quando",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.deepOrange,
                elevation: 3.0,
                textColor: Colors.black,
                onPressed: () {
                  if (resp != null) {
                    setState(() {
                      pressed = true;
                    });
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 25),
            // to display text on clicking the button
            pressed
                ? Column(
                    children: <Widget>[
                      Text(
                        resp,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Quando",
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ButtonTheme(
                        child: RaisedButton(
                          elevation: 4.0,
                          color: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            height: 50,
                            width: 130,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "know more",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "Quando",
                                  ),
                                ),
                                Icon(
                                  FontAwesomeIcons.chevronCircleRight,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                          onPressed: () {
                            String plant = "null";
                            if (plant_name.startsWith("Apple")) {
                              plant = "Apple";
                            } else if (plant_name.startsWith("Grapes")) {
                              plant = "Grapes";
                            } else if (plant_name.startsWith("Peach")) {
                              plant = "Peach";
                            } else if (plant_name.startsWith("Tomato")) {
                              plant = "Tomato";
                            }
                            //if plant value is null goto the home page
                            if (plant!="null") {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => get_info(plant),
                              ));
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      )
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    ));
  }
}
