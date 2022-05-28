import 'package:clima_api_app/service/location.dart';
import 'networking.dart';


const apikey = '34d5918d975f1706722749ac25ea0ac5';
const openmapurl ='https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkingHelper networkHelper = NetworkingHelper(
        '$openmapurl?q=$cityName&appid=$apikey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }


  Future<dynamic> getLocationWeather ()async {
  Location location = Location();
  await location.getCurrentPosition();

  // latitute = location.langitute;
  // longitute = location.longitute;

  NetworkingHelper networkingHelper = NetworkingHelper(
      '$openmapurl?lat=${location.langitute}&lon=${location.longitute}&appid=$apikey');
  var weatherdata = await networkingHelper.getData();

  return weatherdata;
}
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}