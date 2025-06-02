import 'dart:convert';

import 'package:clima/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location.dart';
import 'package:http/http.dart' as http;
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    if(mounted){
      getLocation();
    }
    super.initState();
  }
  @override
    void getLocation() async {
     Location location = Location();
     await location.getCurrentLocation();
     double lat = location.latitude;
     double lon = location.longitude;
     var apiKey = "5e3d8c1518150dd42557fa0c299b1fa8";
     var apiUrl = "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid=5e3d8c1518150dd42557fa0c299b1fa8";
     var url = Uri.https("api.openWeatherMap.org", "/data/2.5/weather", {"lat": lat.toString() , "lon": lon.toString(), "appid": apiKey});
     print(url);
     var response = await http.get(url);
     if(response.statusCode == 200){
       var data = jsonDecode(response.body);
       print(data);
       Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen(),));
     }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.grey,
          size: 50,
        )
      ),
    );
  }
}
