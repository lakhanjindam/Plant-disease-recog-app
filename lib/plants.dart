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

  //creating a custom  card for each plant
Widget customcard(String plant_name,String image, String des){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0,
      ),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            // in changelog 1 we will pass the langname name to ther other widget class
            // this name will be used to open a particular JSON file
            // for a particular language
            builder: (context) => get_info(plant_name),
          ));
        },
        child: Material(
          color: Colors.redAccent,

          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
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
                        fontFamily: "Alike"
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


  @override
  /*
  Color gradientStart = Colors.deepPurple[700]; //Change start gradient color here
  Color gradientEnd = Colors.purple[500]; //Change end gradient color here
*/

@override
Widget build(BuildContext context) {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
  ]);
  return Scaffold(
    appBar: AppBar(
      elevation: 3.0,
      centerTitle: true,
      title: Center(
        child: Text(
          "PlantAPI",
          style: TextStyle(
            fontFamily: "Quando",
          ),
        ),
      ),

      backgroundColor: Colors.black,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
    ),
    body: new Container(
      color: Colors.black87,
      /*
      decoration: new BoxDecoration(
        gradient: new LinearGradient(colors: [gradientStart, gradientEnd],
            begin: const FractionalOffset(0.5, 0.0),
            end: const FractionalOffset(0.0, 0.5),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp
        ),
      ),*/

      child:ListView(
        children: <Widget>[
          //passing json file_name in the function parameters along with images and description
          customcard("Tomato", images[0], des[0]),
          customcard("Peach", images[1], des[1]),
          customcard("Grapes", images[2], des[2]),
          customcard("Apple", images[3], des[3]),
        ],
      ),
    ),
  );
}
}
