
import 'package:geolocator/geolocator.dart';


class Location {

  late double langitute;
  late double longitute;

  Future<void>getCurrentPosition() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    try{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      langitute = position.latitude;
      longitute = position.longitude;
    } catch(e){
      print(e);
    }
  }

}

