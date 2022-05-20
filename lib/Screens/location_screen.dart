import 'package:flutter/material.dart';

import '../Utitlites/constants.dart';

class LocationScreen extends StatefulWidget {

  LocationScreen({required this.locationWeather});
  final String locationWeather;


  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  late double temp;
  late String cityname ;
  late int condition;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.locationWeather);
  }

  void updateUI(dynamic weatherdata){
     temp= weatherdata['main']['feels_like'];
 cityname = weatherdata['name'];
 condition = weatherdata['weather'][0]['id'];


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
                       TextButton(onPressed: (){},
                           child: Icon(
                             Icons.near_me,
                             size: 50.0,
                             color: Colors.white,
                           ),),
                       TextButton(onPressed: (){},
                         child: Icon(
                           Icons.location_city,
                           size: 50.0,
                           color: Colors.white,
                         ),)
                     ],
                   ),
              Padding(
                padding:  EdgeInsets.only(left:15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '32°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "It's 🍦 time in San Francisco!",
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
