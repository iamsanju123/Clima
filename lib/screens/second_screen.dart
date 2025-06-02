import 'dart:convert';
import 'package:clima/screens/home_screen.dart';
import 'package:clima/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondScreen extends StatefulWidget {
  final dynamic weatherData;
  const SecondScreen({super.key, this.weatherData});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final String apiKey = "5e3d8c1518150dd42557fa0c299b1fa8";

  String? cityName;
  String? currentWeather;
  String? tempInCel;
  String? emoji;

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      updateUI(widget.weatherData);
                    },
                    icon: Icon(Icons.near_me, size: 30, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () async {
                      var typedCityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThirdScreen(),
                        ),
                      );

                      if (typedCityName != null && typedCityName != "") {
                        var weatherData = await getWeatherDataCityName(typedCityName);
                        updateUI(weatherData);
                      }
                    },
                    icon: Icon(Icons.location_on, size: 30, color: Colors.white),
                  ),
                ],
              ),
              Text(
                cityName ?? "Unknown Location",
                style: TextStyle(
                    color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                "${tempInCel ?? '--'}°C",
                style: TextStyle(
                    color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    emoji ?? "❓",
                    style: TextStyle(fontSize: 100),
                  ),
                  SizedBox(width: 10),
                  Text(
                    currentWeather ?? "Unknown",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 60),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String kelvinToCel(dynamic temp) {
    double tempInKelvin = temp.toDouble();
    double tempInCelsius = tempInKelvin - 273.15;
    return tempInCelsius.floor().toString();
  }

  Future<dynamic> getWeatherDataCityName(String cityName) async {
    var url = Uri.https("api.openweathermap.org", "/data/2.5/weather", {
      "q": cityName,
      "appid": apiKey,
    });
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      print("Failed to get weather data");
      return null;
    }
  }

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      print("weatherData is null");
      return;
    }

    setState(() {
      try {
        var weatherId = weatherData["weather"][0]["id"];
        if (weatherId > 100 && weatherId < 200) {
          emoji = "🌩️";
        } else if (weatherId > 300 && weatherId < 400) {
          emoji = "🌧️";
        } else if (weatherId > 500 && weatherId < 600) {
          emoji = "☁️";
        } else if (weatherId >= 700) {
          emoji = "🌥️";
        } else {
          emoji = "☀️"; // default sunny
        }

        var temp = weatherData["main"]["temp"];
        tempInCel = kelvinToCel(temp);
        currentWeather = weatherData["weather"][0]["main"];
        cityName = weatherData["name"];
      } catch (e) {
        print("Error parsing weather data: $e");
        emoji = "";
        tempInCel = "--";
        currentWeather = "";
        cityName = "";
      }
    });
  }
}
