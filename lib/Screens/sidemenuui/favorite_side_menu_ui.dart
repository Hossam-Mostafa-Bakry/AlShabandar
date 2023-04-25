import 'package:flutter/material.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:mishwar/main.dart';

import '../CustomAppBar.dart';
import '../Favourite.dart';

class FavoriteSideMenu extends StatefulWidget {
  @override
  _FavoriteSideMenuState createState() => _FavoriteSideMenuState();
}

class _FavoriteSideMenuState extends State<FavoriteSideMenu> {
  home h = home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(h.mainColor),
        title: Text(
          DemoLocalizations.of(context).title['favorite'],
          style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        leading:  GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: DemoLocalizations.of(context).locale == Locale("en")
                ? Icon(Icons.arrow_back_ios_rounded,
                size: 25, color: Colors.black)
                : Icon(Icons.arrow_forward_ios_rounded,
                size: 25, color: Colors.black)),
      ),
      body: Favourite(),
    );
  }
}
