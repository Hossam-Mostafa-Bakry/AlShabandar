import 'package:flutter/material.dart';
import 'package:mishwar/Screens/Offers.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:mishwar/Screens/SoonPage.dart';
import 'package:mishwar/main.dart';

class OffersSideMenu extends StatefulWidget {
  @override
  _BranchesSideState createState() => _BranchesSideState();
}

class _BranchesSideState extends State<OffersSideMenu> {
  home h = home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Color(h.mainColor),
          title: Text(
            DemoLocalizations.of(context).title['Offers'],
            style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: DemoLocalizations.of(context).locale == Locale("en")
                  ? Icon(Icons.arrow_back_ios_rounded,
                  size: 25, color: Colors.black)
                  : Icon(Icons.arrow_forward_ios_rounded,
                  size: 25, color: Colors.black)),
        ),
        body: Offers());
  }
}
