import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:plant_app/plant_info.dart';

class predict extends StatefulWidget {
  String data;
  predict(this.data);

  @override
  _predictState createState() => _predictState(data);
}

class _predictState extends State<predict> {
  String data;
  _predictState(this.data);

  String url = "https://6d1be31c.ngrok.io/predict";
  String resp;
  var isLoading =false;
  Future<String> getdata() async{
    //shows loading before fetching the data
    setState(() {
      isLoading=true;
    });
    http.Response response = await http.post(url, body: {"plant_image":"data:image/jpeg;base64,"+data});

    if(response.statusCode==200){
      setState(() {
        var res = (json.decode(response.body));
        resp = res["data"];
        resp = resp.replaceAll("_", " ");
        resp = "Your plant os diagnosed with: "+resp+" disease.";
      });
      //after retrieving the data stops the loading
      setState(() {
        isLoading=false;
      });
    }else
      if (response.statusCode==400){
      resp = "Invalid request!";
      setState(() {
        isLoading=false;
      });
  }else
    if(response.statusCode==503){
      resp = "No internet connection!";
      setState(() {
        isLoading=false;
      });
  }
    else{
      {
        resp = null;
        setState(() {
          isLoading=false;
        });
      }
      print(resp);
    }

  }

  bool pressed = false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
        title:Text("prediction of disease"),
        ),
        body:
      Container(
        color: Colors.black87,
        child: Center(
          child: Column(

            children: <Widget>[
              SizedBox(height: 40),
              ButtonTheme(
                height: 50,
                minWidth: 100,
                child: RaisedButton(

                  child: Text(
                      "Predict",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Quando",
                  ),),
                  color: Colors.deepOrange,
                  elevation: 3.0,
                  textColor: Colors.black,
                  onPressed: (){
                        getdata();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                ),
              ),
              SizedBox(height: 30,),
              isLoading ?
                  CircularProgressIndicator()
              : SizedBox(),
              SizedBox(height: 40),

              ButtonTheme(
                height: 50,
                minWidth: 100,
                child: RaisedButton(
                  child: Text(
                      "Show data",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Quando",
                    ),),
                  color: Colors.deepOrange,
                  elevation: 3.0,
                  textColor: Colors.black,
                  onPressed: (){
                    if(resp!=null){
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
              pressed?
                  Column(
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
                      SizedBox(height: 30,),
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
                          onPressed: (){
                            String plant;
                            if (resp.startsWith("Apple")){
                              plant = "Apple";
                            }else if(resp.startsWith("Grapes")){
                              plant = "Grapes";
                            }else if (resp.startsWith("Peach")){
                              plant = "Peach";
                            }else if(resp.startsWith("Tomato")){
                              plant = "Tomato";
                            }
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              // in changelog 1 we will pass the langname name to ther other widget class
                              // this name will be used to open a particular JSON file
                              // for a particular language
                              builder: (context) => get_info(plant),
                            ));

                          },
                        ),
                      )
                    ],

                  )
               : SizedBox(),
            ],
          ),
        ),
      )
    );
  }
}

