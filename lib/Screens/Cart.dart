import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/Model/CartModelLocal.dart';
import 'package:mishwar/Screens/slmlmProvider.dart';
import 'package:mishwar/Screens/subItemCart.dart';
import 'package:mishwar/app/Services/OrderServices.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../Model/cart_model.dart';
import 'GlobalFunction.dart';
import 'package:mishwar/Screens/HomePage.dart';
import '../dbHelper.dart';
import '../main.dart';
import 'confirmedorderui/first_step_user_data.dart';
import 'login.dart';
import 'package:mishwar/lang/app_Localization.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<Cart> {
  home h = new home();
  List dataLocal = [];
  List data = [];
  DbHelper db = new DbHelper();
  SlmlmProvider slmlmProvider;
  int totalquantity = 0;
  double allPrice = 0.0;
  double tax = 0.0;
  bool init = true;
  double width = 40;
  bool isCliked = false;

  @override
  void didChangeDependencies() async {
    if (init) {
      slmlmProvider = Provider.of<SlmlmProvider>(context, listen: false);
      await slmlmProvider.getTotal();

      init = false;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: db.allProduct(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                print("${snapshot.data.toString()}.. length");
                return snapshot.data.length == 0
                    ? Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .15,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Image.asset(
                                "images/icon/cart.png",
                                color: Colors.black26,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .035,
                              ),
                              //nocartdata
                              Text(
                                DemoLocalizations.of(context)
                                    .title['nocartdata'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black26,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .035,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/mainPage',
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: DottedBorder(
                                  color: Colors.black26,
                                  strokeWidth: 1.5,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .6,
                                    height: MediaQuery.of(context).size.height *
                                        .06,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      //  border: Border.all(width: 1.0,color: Colors.black26)
                                    ),
                                    child: Text(
                                      DemoLocalizations.of(context)
                                          .title['shopnow'],
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              DeleteFromCart(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.height * .002,
                                vertical:
                                    MediaQuery.of(context).size.width * .002,
                              ),
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .008,
                                left: MediaQuery.of(context).size.width * .05,
                                right: MediaQuery.of(context).size.width * .05,
                              ),
                              height: 23,
                              width: 75,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Color(h.mainColor), width: 0.5),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Clear Cart',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(h.mainColor),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .01,
                              ),
                              itemBuilder: (context, index) {
                                String i = snapshot.data[index]["subItems"];
                                // print("$i..subtitles");
                                // print("${i.runtimeType}..subtitles");
                                List<dynamic> mappedList = jsonDecode(i);
                                // print("${mappedList.runtimeType}..mappedList");
                                // print("${mappedList.length}..mappedList length");
                                List<SubItem> subItemList = mappedList.map((e) => SubItem.fromMap(e)).toList();
                                // print("${subItemList.runtimeType}..subItemList");
                                // print("${subItemList.length}..subItemList length");
                                CartModel c = new CartModel.fromMap(
                                    snapshot.data[index], subItemList: subItemList);
                                print("${mappedList}..mappedList length");
                                // print(subItemList[0].subItemName);
                                // print(subItemList[0].subItemQuntity);
                                // print(c.subItems);
                                return SubItemCart(c);
                              },
                            ),
                          ),
                        ],
                      );
              }
            },
          ),
        ),
        Consumer<SlmlmProvider>(
          builder: (context, ch, _) {
            if (ch.totalquantity < 1) {
              return Container();
            } else {
              return Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .05,
                  right: MediaQuery.of(context).size.width * .05,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(color: Colors.black12, width: 1),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                              color: Color(0xffdedede).withOpacity(.5),
                            ),
                            alignment: Alignment.center,
                            //paymentDetails
                            child: Text(
                              DemoLocalizations.of(context)
                                  .title['paymentDetails'],
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * .3 - 2,
                                height:
                                    MediaQuery.of(context).size.height * .04,
                                decoration: BoxDecoration(),
                                alignment: Alignment.center,
                                child: Text(
                                  DemoLocalizations.of(context).title['qunt'],
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .3,
                                height:
                                    MediaQuery.of(context).size.height * .04,
                                decoration: BoxDecoration(),
                                alignment: Alignment.center,
                                child: Text(
                                  DemoLocalizations.of(context).title['Tax'] +
                                      '% 15',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .3,
                                height:
                                    MediaQuery.of(context).size.height * .04,
                                decoration: BoxDecoration(),
                                alignment: Alignment.center,
                                child: Text(
                                  DemoLocalizations.of(context)
                                      .title['Totaldemand'],
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          // Divider
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width * .27,
                                color: Colors.black12,
                              ),
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width * .27,
                                color: Colors.black12,
                              ),
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width * .27,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * .3 - 2,
                                height:
                                    MediaQuery.of(context).size.height * .04,
                                decoration: BoxDecoration(),
                                alignment: Alignment.center,
                                child: Text(
                                  ch.totalquantity.toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .3,
                                height:
                                    MediaQuery.of(context).size.height * .04,
                                decoration: BoxDecoration(),
                                alignment: Alignment.center,
                                child: Text(
                                  ch.tax.toStringAsFixed(2) +
                                      ' ' +
                                      DemoLocalizations.of(context)
                                          .title['currency'],
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .3,
                                height:
                                    MediaQuery.of(context).size.height * .04,
                                decoration: BoxDecoration(),
                                alignment: Alignment.center,
                                child: Text(
                                  ((ch.allPrice).toStringAsFixed(2))
                                          .toString() +
                                      ' ' +
                                      DemoLocalizations.of(context)
                                          .title['currency'],
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(
                            //right:  MediaQuery.of(context).size.width*.2,
                            //left:  MediaQuery.of(context).size.width*.2
                            ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(h.blueColor),
                        ),
                        height: MediaQuery.of(context).size.height * .05,
                        //  width: MediaQuery.of(context).size.width*.8,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .07,
                          right: MediaQuery.of(context).size.width * .07,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DemoLocalizations.of(context).title['Total'] +
                                  " " +
                                  (ch.allPrice).toStringAsFixed(2).toString() +
                                  " " +
                                  DemoLocalizations.of(context)
                                      .title['currency'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              DemoLocalizations.of(context)
                                  .title['Continuetopurchase'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        if (ch.allPrice > 30.0) {
                          if (home.username == null) {
                            Navigator.push(
                              context,
                              GlobalFunction.routeBottom(Login("cart")),
                            );
                          } else {
                            Navigator.push(
                              context,
                              GlobalFunction.routeBottom(FirstStepUserData()),
                            );
                          }
                        } else {
                          Toast.show(
                            DemoLocalizations.of(context)
                                .title['ordermorethan'],
                            context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM,
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                  ],
                ),
              );
            }
          },
        )
      ],
    );
  }

  AddToCard(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 130.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              border: Border.all(color: Colors.black12, width: 2.0),
              color: Colors.white),
          child: Stack(
            children: <Widget>[
              Column(
                //mainAxisAlignment: MainAxisAlignment.center
                // ,crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      color: Colors.white),
                                  // padding:EdgeInsets.all(2),
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 13),
                                  child: Icon(
                                    Icons.check_circle_outline,
                                    size: 50,
                                    color: Color(h.mainColor),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1000)),
                                        color: Color(h.mainColor)),
                                    padding: EdgeInsets.all(2.5),
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "تم اضافة الطلب بنجاح",
                            style: TextStyle(
                                color: Color(h.blueColor),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DeleteFromCart(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 150.0,
          decoration: BoxDecoration(
            //border: Border.all(color: Colors.black12,width: 2.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "images/icon/about.png",
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        DemoLocalizations.of(context)
                            .title['Doyouwanttoclearcart'],
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(h.blueColor)),
                            height: MediaQuery.of(context).size.height * .045,
                            width: MediaQuery.of(context).size.width * .33,
                            alignment: Alignment.center,
                            child: Text(
                              DemoLocalizations.of(context).title['cancel'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(h.mainColor)),
                            height: MediaQuery.of(context).size.height * .045,
                            width: MediaQuery.of(context).size.width * .33,
                            alignment: Alignment.center,
                            child: Text(
                              DemoLocalizations.of(context).title['confirm'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          onTap: () async {
                            setState(() {
                              db.deleteCart();
                              Provider.of<SlmlmProvider>(context, listen: false)
                                  .totalquantity = 0;
                            });

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (_) => HomePage(
                                          index: 2,
                                        )),
                                (Route<dynamic> route) => false);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Items {
  String ItemID;
  String Quantity;
  String SalePrice;
  String SubTotal;
  String TotalValue;
  String Notes;

  Items({
    this.ItemID,
    this.Quantity,
    this.SalePrice,
    this.SubTotal,
    this.TotalValue,
    this.Notes,
  });

  Map<String, dynamic> toJson() => {
        "ItemID": ItemID,
        "Quantity": Quantity,
        "SalePrice": SalePrice,
        "SubTotal": SubTotal,
        "TotalValue": TotalValue,
        "Notes": Notes,
      };
}
