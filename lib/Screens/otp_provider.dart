import 'dart:async';

import 'package:flutter/material.dart';

class OTPProvider extends ChangeNotifier {

  bool allowResend = false;
  String resendWait;
  Timer _timer;
  String _seconds;
  String _minutes;

  void startTimer() {
    allowResend = false;
    resendWait = "01:00";
    _seconds = "00";
    _minutes = "01";
    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (Timer timer) {
        if (int.tryParse(_seconds) == 0) {
          if (int.tryParse(_minutes) == 0) {
            debugPrint("timer end");
            allowResend = true;
            notifyListeners();

            timer.cancel();
          } else {
            _minutes = "00";
            _seconds = "59";
          }
        } else {
          int temp = int.tryParse(_seconds) - 1;
          if (temp >= 10) {
            _seconds = temp.toString();
          } else {
            _seconds = "0" + temp.toString();
          }
        }
        resendWait = _minutes + ":" + _seconds;
        notifyListeners();
      },
    );
  }

  void cancelTimer() {
    _timer.cancel();
  }
}