import 'package:bot_toast/bot_toast.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:mishwar/Screens/DelveryUser/getbranch.dart';

import 'package:mishwar/Screens/Splash.dart';
import 'package:mishwar/app/AppConfig.dart';
import 'package:provider/provider.dart';
// import 'package:google_map_location_picker/generated/l10n.dart' as location_picker;

import 'Screens/Addreses.dart';

import 'Screens/DelveryUser/MapsProvider.dart';
import 'Screens/DelveryUser/getDeliveryValueProvider.dart';
import 'Screens/HomePage.dart';
import 'Screens/LanguageUi.dart';
import 'Screens/Register.dart';
import 'Screens/Slider.dart';
import 'Screens/Verification.dart';
import 'Screens/VerificationDone.dart';
import 'Screens/confirmedorderui/networkUtlis.dart';
import 'Screens/confirmedorderui/onlinePayment.dart';
import 'Screens/confirmedorderui/paymentProvider.dart';
import 'Screens/login.dart';
import 'Screens/Orders.dart';

import 'Screens/DelveryUser/DeleveryHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/main_provider.dart';
import 'Screens/map_customize.dart';
import 'Screens/slmlmProvider.dart';
import 'Services/loading_service.dart';
import 'lang/app_LocalizationDeledate.dart';


import 'Screens/DelveryUser/DeliveryOrders.dart';
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//
//   print("Handling a background message: ${message.messageId}");
// }

Future<void> main() async {
  await appConfig.init();
  await appConfig.cApp.initLocal();
  // await FCMConfig.instance.init(
  //   onBackgroundMessage: _firebaseMessagingBackgroundHandler,
  //   alert: true,
  //   announcement: true,
  //   badge: true,
  //   displayInForeground: true,
  //   carPlay: false,
  //   criticalAlert: true,
  //   provisional: false,
  //   sound: true,
  //   defaultAndroidChannel: null,
  // );
  await appConfig.cApp.initLocal();
  runApp(
    Phoenix(
      child: ParentPage(),
    ),
  );
  configLoading();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class home extends StatelessWidget {
  int mainColor = 0xFFFF9800;
  int blueColor = 0xFF000000;
  int bgColor = 0xfff1fbf7;
  int borderColor = 0xffe7e7e7;
  int FocusBorderColor = 0xfffccfcc;
  int ErorrBorderColor = 0xfff00f00;
  int whiteColor = 0xffF7F9FC;
  static String username;
  static String phone;
  static String userImag;
  static String email;

  @override
  Widget build(BuildContext context) {

    final botToastBuilder = BotToastInit();
    return Observer(
      builder: (_) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SlmlmProvider()),
          ChangeNotifierProvider(create: (_) => MapProvider()),
          ChangeNotifierProvider(create: (_) => GetDeliveryValueProvider()),
          // ChangeNotifierProvider(create: (_) => PayMentProvider()),
          ChangeNotifierProvider(create: (_) => NetworkUtil()),
          ChangeNotifierProvider(create: (_) => GetUserBranch()),
          ChangeNotifierProvider(create: (_) => MainProvider(),),
        ],
        child: MaterialApp(
          localizationsDelegates: [
            // location_picker.S.delegate,
            const AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale("en", ""), // OR Locale('ar', 'AE') OR Other RTL locales
            Locale("ar", ""),
          ],
          locale: appConfig.cApp.appLocale,
          theme: ThemeData(
            primaryColor: Color(blueColor),
            fontFamily: 'mishwarfont',
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Color(0xff55b866)),
          ),
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(builder: BotToastInit()),
          // builder: (context, child) {
          //   child = botToastBuilder(context, child);
          //   return MediaQuery(
          //     data: MediaQuery.of(context).copyWith(
          //       textScaleFactor: 1.0,
          //     ),
          //     child: child,
          //   );
          // },
          routes: <String, WidgetBuilder>{
            '/slider': (BuildContext context) => new slider(),
            '/login': (BuildContext context) => new Login("home"),
            '/Register': (BuildContext context) => new Register(),
            '/Adresses': (BuildContext context) => new Adresses(),
            '/Orders': (BuildContext context) => new Orders(),
            '/verification': (BuildContext context) => new verification("", "",),
            '/mainPage': (BuildContext context) => new HomePage(),
            '/DeleverMain': (BuildContext context) => new DeleveryHome(),
            '/DeliveryOrders': (BuildContext context) => new DeliveryOrders(),
            '/Cart': (BuildContext context) => new HomePage(),
            '/fav': (BuildContext context) => new HomePage(),
            '/VerificationDone': (BuildContext context) =>
                new VerificationDone(),
            '/LanguageUi': (BuildContext context) => LanguageUi(),
          },
          home: Splash(),
        ),
      ),
    );
  }
}

class ParentPage extends StatefulWidget {
  static String userType;
  static int counter;
  static String address;

  @override
  _State createState() => _State();
}

class _State extends State<ParentPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  _register() async {
    await FCMConfig.messaging.getToken().then((token) {
      SharedPreferences.getInstance().then((shared) {
        shared.setString('token', token);
      });

      print('${token},,,,,,toookkk');
    });
    print(
        "_____________________________________________________________________________________________________________");
  }

  // void getMessage()async{
  //   _firebaseMessaging.configure(
  //       onMessage: (Map<String, dynamic> message) async {
  //         showNotificationsFunc(message);
  //         print('on message $message');
  //         setState(() => _message = message["notification"]["title"]);
  //       }, onResume: (Map<String, dynamic> message) async {
  //     print('on resume $message');
  //     setState(() => _message = message["notification"]["title"]);
  //   }, onLaunch: (Map<String, dynamic> message) async {
  //     print('on launch $message');
  //     setState(() => _message = message["notification"]["title"]);
  //   });
  // }
  // showNotificationsFunc(Map<String, dynamic> message) async {
  //   var android = AndroidNotificationDetails(
  //     'channel_id',
  //     'CHANNEL_NAME',
  //     channelDescription: 'channelDescription',
  //   );
  //   var ios = IOSNotificationDetails();
  //   var platform = new NotificationDetails(android: android, iOS: ios);
  //   await flutterLocalNotificationsPlugin.show(
  //       0,
  //       message['notification']['title'].toString(),
  //       message['notification']['body'].toString(),
  //       platform);
  // }

  @override
  void initState() {
    // TODO: implement initState
    //  secureScreen();
    super.initState();
    // var android = new AndroidInitializationSettings('mipmap/launcher_icon');
    // var ios = IOSInitializationSettings();
    // var platform = InitializationSettings(android: android, iOS: ios);
    // flutterLocalNotificationsPlugin.initialize(platform);
    // //  getMessage();
    // _register();
  }

  @override
  Widget build(BuildContext context) {
    return home();
  }
}

//cJXWJLaJRZiNrd0wLuxg_E
//cJXWJLaJRZiNrd0wLuxg_E
