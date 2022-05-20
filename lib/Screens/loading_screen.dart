import 'dart:core';
import 'package:clima_api_app/service/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../service/location.dart';
import 'location_screen.dart';

const apikey = '34d5918d975f1706722749ac25ea0ac5';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitute;
  late double longitute;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentPosition();

    latitute = location.langitute;
    longitute = location.longitute;

    NetworkingHelper networkingHelper = NetworkingHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitute&lon=$longitute&appid=$apikey');
    var weatherdata = await networkingHelper.getData();
   // print(weatherdata);
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationWeather: weatherdata,);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('press me'),
          onPressed: () {
            //  getLocationData();
            // getData();
          },
        ),
      ),
    );
  }
}
