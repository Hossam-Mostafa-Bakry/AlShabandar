import 'package:mishwar/app/AppConfig.dart';
import 'package:mishwar/app/Services/UserServices.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class Splash extends StatefulWidget {
  static void RefreshUser() {}

  @override
  State<StatefulWidget> createState() {
    return splashState();
  }
}

class splashState extends State<Splash> {
  var first;
  home h = new home();
  Map<String, dynamic> data;
  UserServices userServices = new UserServices();
  String userType = '';

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    !prefs.containsKey("UserId") == null
        ? print("")
        : data = await userServices.getUserData(prefs.getString("UserId"));
    setState(() {
      home.userImag = data["image"];
      home.phone = data["phone"];
      home.username = data["name"];
      home.email = data["email"];
      userType = prefs.getString("UserType");
    });
    setState(() {
      first = prefs.getString("first");
    });
    debugPrint(home.username);
    debugPrint('${userType},,,,,,,,userType');
    debugPrint("_________________________________________________________________________________________________");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      print('${appConfig.prefs.getString('chooselang')},,,,datatata');
      if (appConfig.prefs.getString('chooselang') == 'yes') {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/slider', (Route<dynamic> route) => false);
      } else if (appConfig.prefs.containsKey('chooselang')) {
        if (userType == "2") {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/DeleverMain'
              //userType=="2"?"/DeleverMain":"/mainPage", DeleverMain mainPage
              ,
              (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/mainPage'
              //userType=="2"?"/DeleverMain":"/mainPage",
              ,
              (Route<dynamic> route) => false);
        }
      }
      else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/LanguageUi'
            //userType=="2"?"/DeleverMain":"/mainPage",
            ,
            (Route<dynamic> route) => false);
      }
    });

    return Container(
      decoration: new BoxDecoration(
          /*  image: new DecorationImage(
          image: new ExactAssetImage('images/Splash.png'),
          fit: BoxFit.cover,
        ),*/
          color: Color(h.mainColor)),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .35),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 115,
            child: Container(
              height: 210,
              width: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('images/app_icon_image.jpg'),
                ),
                border: Border.all(
                  color: Colors.orange.shade400,
                ),
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Text(
            "من فضلك انتظر تحميل التطبيق",
            style: TextStyle(
                fontFamily: "mishwarfont",
                decoration: TextDecoration.none,
                fontSize: 13,
                color: Colors.white),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            "Please Wait For Application Loading",
            style: TextStyle(
                fontFamily: "mishwarfont",
                decoration: TextDecoration.none,
                fontSize: 13,
                color: Colors.white),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          )
        ],
      ),
    );
  }
}
