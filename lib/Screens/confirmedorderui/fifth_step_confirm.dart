import 'package:mishwar/Screens/CartOrder.dart';
import 'package:mishwar/Screens/confirmedorderui/second_step_address.dart';
import 'package:mishwar/Screens/confirmedorderui/third_step_delivery.dart';
import 'package:mishwar/Screens/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:mishwar/Screens/HomePage.dart';
import 'package:mishwar/app/AppConfig.dart';

import '../../main.dart';
import 'first_step_user_data.dart';
import 'fourth_step_payment.dart';

class FifthStepConfirm extends StatefulWidget {
  @override
  _FifthStepConfirmState createState() => _FifthStepConfirmState();
}

class _FifthStepConfirmState extends State<FifthStepConfirm> {
  home h = home();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false);

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Color(h.mainColor),
          title: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: DemoLocalizations.of(context).locale == Locale("en")
                      ? Icon(Icons.arrow_back_ios_rounded,
                          size: 25, color: Colors.white)
                      : Icon(Icons.arrow_back_ios_rounded,
                          size: 25, color: Colors.white)),
              Expanded(
                child: Text(
                  DemoLocalizations.of(context).title['followupwiththeorder'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.05),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05,
                  bottom: MediaQuery.of(context).size.width * 0.05,
                  left: 10,
                  right: 10,
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FirstStepUserData(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                              ),
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                                DemoLocalizations.of(context).title['username'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DottedLine(
                                dashColor: Colors.black87,
                                lineThickness: 2.0,
                                dashGapLength: 1.50,
                                dashRadius: 1.0,
                              ),
                              SizedBox(
                                height: 15.0,
                              )
                            ],
                          ),
                        ),
                        if(appConfig.prefs.getInt('delmethodvalue') == 2)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SecondStepAddress(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                              ),
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(DemoLocalizations.of(context).title['address'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        if(appConfig.prefs.getInt('delmethodvalue') == 2)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DottedLine(
                                dashColor: Colors.black87,
                                lineThickness: 2.0,
                                dashGapLength: 1.50,
                                dashRadius: 1.0,
                              ),
                              SizedBox(
                                height: 15.0,
                              )
                            ],
                          ),
                        ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       child: IconButton(
                        //         onPressed: () {
                        //           Navigator.pushReplacement(
                        //             context,
                        //             MaterialPageRoute(
                        //               builder: (context) => ThirdStepDelivery(),
                        //             ),
                        //           );
                        //         },
                        //         icon: Icon(
                        //           Icons.check,
                        //           color: Colors.white,
                        //           size: 25.0,
                        //         ),
                        //       ),
                        //       width: 40.0,
                        //       height: 40.0,
                        //       decoration: BoxDecoration(
                        //           color: Theme.of(context).primaryColor,
                        //           shape: BoxShape.circle),
                        //     ),
                        //     SizedBox(
                        //       height: 5.0,
                        //     ),
                        //     Text(
                        //         DemoLocalizations.of(context).title['Delivery'],
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .headline2
                        //             .copyWith(
                        //                 fontSize: 11.0,
                        //                 fontWeight: FontWeight.w600,
                        //                 color: Colors.black),
                        //         textAlign: TextAlign.right),
                        //   ],
                        // ),
                        // Expanded(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       DottedLine(
                        //         dashColor: Colors.black87,
                        //         lineThickness: 2.0,
                        //         dashGapLength: 1.50,
                        //         dashRadius: 1.0,
                        //       ),
                        //       SizedBox(
                        //         height: 15.0,
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FourthStepPayment(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                              ),
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(DemoLocalizations.of(context).title['payment'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DottedLine(
                                dashColor: Colors.black87,
                                lineThickness: 2.0,
                                dashGapLength: 1.50,
                                dashRadius: 1.0,
                              ),
                              SizedBox(
                                height: 15.0,
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              DemoLocalizations.of(context).title['confirm'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
              Expanded(child: CartOrder()),
            ],
          ),
        ),
      ),
    );
  }
}
