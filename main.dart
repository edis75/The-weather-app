import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      title: "The weather app",
      debugShowCheckedModeBanner: false,
      home: Home(),
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var curently;
  var humidity;
  var windspeed;

  Future getWeather () async {
    var url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Ardahan&appid=b5959f2b02766c9ce4ce7d58a2300f00");
    http.Response response= await http.get(url);
    var result = jsonDecode(response.body);
    setState(() {
      this.temp=result['main']['temp'];
      this.description=result['weather'][0]['description'];
      this.curently=result['weather'][0]['main'];
      this.humidity=result['main']['humidity'];
      this.windspeed=result['wind']['speed'];
    });
 }
  @override
  void initState(){
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              color: Colors.orange,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Currently in Ardahan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    temp!=null ? temp.toString()+"\u00B0" :"Loading",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      curently!=null ? curently.toString() :"Loading",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.thermostat),
                  title: Text("Temprauture"),
                  trailing: Text(temp !=null ? temp.toString() + "\u00B0" :"Loading"),
                ),
                ListTile(
                  leading: Icon(Icons.cloud),
                  title: Text("Weather"),
                  trailing: Text(description !=null ? description.toString():"Loading"),
                ),
                ListTile(
                  leading: Icon(Icons.sunny),
                  title: Text("Humidity"),
                  trailing: Text(humidity !=null ? humidity.toString() :"Loading"),
                ),
                ListTile(
                  leading: Icon(Icons.speed),
                  title: Text("Wind speed"),
                  trailing: Text(windspeed !=null ? windspeed.toString() :"Loading"),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
