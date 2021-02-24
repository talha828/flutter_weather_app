import'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(
      MaterialApp(
          title: "flutter",
        debugShowCheckedModeBanner:false,
          home:Home(),
  ),);
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var weather;
  var humidity;
  var desc;
  var wind;
  Future getWeather() async {
    http.Response response = await http.get("http://api.openweathermap.org/data/2.5/weather?q=karachi&appid=7be156f187bf9c482b57653593931c5e");
    var result =jsonDecode(response.body);
    setState(() {
      this.temp = result['main']['temp'];
      this.desc =result['weather'][0]['description'];
      this.weather =result['weather'][0]['main'];
      this.humidity =result['main']['humidity'];
      this.wind =result['wind']['speed'];
    });
  }
  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: <Widget>[
          Container(

              height: MediaQuery.of(context).size.height / 3,
              width:  MediaQuery.of(context).size.width,
              color: Colors.blueGrey,
              child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget>[
                    Padding(
                      padding:EdgeInsets.only(bottom:10.0),
                      child:Text(
                        "currently in karachi",
                        style: TextStyle(
                            color:Colors.white,
                            fontSize:14.0,
                            fontWeight:FontWeight.w600
                        ),
                      ),
                    ),
                    Text(
                      temp != null ? temp.toString() + "\u2109" : "loading",
                      style:TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.only(top:10.0),
                      child:Text(
                         weather != null ? weather.toString()  : "loading",
                        style: TextStyle(
                            color:Colors.white,
                            fontSize:14.0,
                            fontWeight:FontWeight.w600
                        ),
                      ),
                    ),
                  ])
          ),
          Expanded(
            child:Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing: Text(temp != null ? temp.toString() + "\u2109" : "loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing: Text(desc != null ? desc.toString():"loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("TemperaHumiditytrue"),
                    trailing: Text(humidity != null ? humidity.toString():"loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(wind != null ? wind.toString():"loading"),
                  ),
                ],
              ),
            )
          )
        ],),
    );

  }
}


