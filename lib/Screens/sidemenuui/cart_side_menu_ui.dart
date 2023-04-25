import 'package:flutter/material.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:mishwar/Screens/Cart.dart';
import 'package:mishwar/main.dart';

class CartSideMenu extends StatefulWidget {
  @override
  _CartSideMenuState createState() => _CartSideMenuState();
}

class _CartSideMenuState extends State<CartSideMenu> {
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
            DemoLocalizations.of(context).title['cart'],
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
        body: Cart());
  }
}
