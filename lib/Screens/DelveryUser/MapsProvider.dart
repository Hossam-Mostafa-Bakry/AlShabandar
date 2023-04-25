import 'package:flutter/cupertino.dart';

class MapProvider extends ChangeNotifier {
  String address;
  double lat, lng;

  selectAddress({String addressParm, double latParm, double lngParm}) {
    address = addressParm;
    lat = latParm;
    lng = lngParm;
    notifyListeners();
  }
}
