import 'package:flutter/cupertino.dart';

class GetDeliveryValueProvider extends ChangeNotifier {

  double priceDelivery = 0.0;

  void getDeliveryValue(double value) {

    priceDelivery = value;
    notifyListeners();


  }
}
