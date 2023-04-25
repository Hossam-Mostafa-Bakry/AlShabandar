import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {

  bool shownFirstTime = false;
  bool selectDeliveryType = false;
  // bool deliveryType = false;

  void changeFlagFirstTimeShown(bool v) {
    shownFirstTime = v;
    notifyListeners();
  }

  void setDeliveryType(bool v) {
    selectDeliveryType = v;
    notifyListeners();
  }

  // void changeDeliveryBoolean(bool v) {
  //   selectDeliveryType = v;
  //   notifyListeners();
  // }

}