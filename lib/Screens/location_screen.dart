import 'package:flutter/material.dart';

import '../Utitlites/constants.dart';
import '../service/wheater.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {

  LocationScreen({required this.locationWeather});
  final String locationWeather;


  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather = WeatherModel();


  late double temprature;
  late String cityname ;
 // late int condition;
  late String weatherIcon;
  late String weathermessage;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherdata){

    setState(() {
      if (weather == null){
        temprature = 0;
        cityname ='';
        weatherIcon ='Error';
        weathermessage='Unable to Load weather Data';
        return;
      }
      double temp= weatherdata['main']['feels_like'];
      temprature = temp.toInt() as double;
      cityname = weatherdata['name'];

      var condition = weatherdata['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weathermessage =  weather.getMessage(temprature.toInt());

    });


  }

  // late double latitute;
  // late double longitute;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),

        ),
        constraints: BoxConstraints.expand(),
        child:SafeArea(
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       FlatButton(
                         onPressed: () async {
                           var weatherData = await weather.getLocationWeather();
                           updateUI(weatherData);
                         },
                         child: Icon(
                           Icons.near_me,
                           size: 50.0,
                         ),
                       ),
                       FlatButton(
                         onPressed: () async {
                           var typedName = await Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) {
                                 return CityScreen();
                               },
                             ),
                           );
                           if (typedName != null) {
                             var weatherData =
                             await weather.getCityWeather(typedName);
                             updateUI(weatherData);
                           }
                         },
                         child: Icon(
                           Icons.location_city,
                           size: 50.0,
                         ),
                       ),
                     ],
                   ),
              Padding(


                padding:  EdgeInsets.only(left:15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                     '$temprature',
                      style: kTempTextStyle,
                    ),
                    Text(
                    weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  ' $weathermessage in $cityname',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}


// onPressed: () async {
// var typedName = await Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) {
// return CityScreen();
// },
// ),
// );
// if (typedName != null) {
// var weatherData =
// await weather.getCityWeather(typedName);
// updateUI(weatherData);
// }
// },
// child: Icon(
// Icons.location_city,
// size: 50.0,
// ),
