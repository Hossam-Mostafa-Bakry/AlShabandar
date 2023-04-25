import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:intl/intl.dart';

import 'package:mishwar/app/Services/OrderServices.dart';
import 'package:mishwar/lang/app_Localization.dart';
import '../Model/OrderDetails.dart';
import '../Model/OrdersModel.dart';
import 'GlobalFunction.dart';
import 'package:mishwar/Screens/HomePage.dart';
import '../main.dart';
import '../Screens/OrderDetails.dart';
import 'package:mishwar/Screens/myDrawer.dart';
import '../Model/OrderStatusModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Orders extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<Orders> {
  String SelectedCategory;
  home h = new home();
  int index = 0;
  List<String> data = ["", "", ""];
  OrderServices orderServices = new OrderServices();
  List<OrderStatusDetail> orderStatus = [];
  List<OrdersList> orders;
  List<OrderDetails> orderDetails;

  getOrder(var status_id) async {
    orders == null;
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    orders = await orderServices.GetOrdersUpdate(
        prefs.getString("UserId"), status_id);

    setState(() {});
  }

  loadData() async {
    orderStatus = await orderServices.GetOrderStatusUser();
    setState(() {
      SelectedCategory = orderStatus[0].id;
    });
    getOrder(orderStatus[0].id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, "/mainPage", (route) => false);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(h.mainColor),
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            DemoLocalizations.of(context).title['myorders'],
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/mainPage", (route) => false);
              },
              child: DemoLocalizations.of(context).locale == Locale("en")
                  ? Icon(Icons.arrow_back_ios_rounded,
                      size: 25, color: Colors.black)
                  : Icon(Icons.arrow_forward_ios_rounded,
                      size: 25, color: Colors.black)),
        ),
        key: _scaffoldKey,
        endDrawer: MyDrawer(),
        body: Container(
          child: Column(
            children: [
              // Container(
              //   height: MediaQuery
              //       .of(context)
              //       .size
              //       .height * .07,
              //   child: Container(
              //     height: MediaQuery
              //         .of(context)
              //         .size
              //         .height * .07,
              //     color: Color(h.mainColor),
              //     padding: EdgeInsets.only(
              //       left: MediaQuery
              //           .of(context)
              //           .size
              //           .width * .05,
              //       right: MediaQuery
              //           .of(context)
              //           .size
              //           .width * .05,
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         GestureDetector(
              //             onTap: () {
              //               Navigator.pushNamedAndRemoveUntil(
              //                   context, "/mainPage", (route) => false);
              //             },
              //             child: DemoLocalizations
              //                 .of(context)
              //                 .locale ==
              //                 Locale("en")
              //                 ? Icon(Icons.arrow_back_ios_rounded,
              //                 size: 25, color: Colors.white)
              //                 : Icon(Icons.arrow_forward_ios_rounded,
              //                 size: 25, color: Colors.white)),
              //         Text(
              //           DemoLocalizations
              //               .of(context)
              //               .title['myorders'],
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 20,
              //               fontWeight: FontWeight.w500),
              //         ),
              //         GestureDetector(
              //             onTap: () {},
              //             child: Icon(
              //               Icons.arrow_forward_outlined,
              //               color: Color(h.mainColor),
              //               size: 25,
              //             ))
              //       ],
              //     ),
              //   ),
              // ),
              Container(
                height: 26 + MediaQuery.of(context).size.height * .025,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .03,
                    left: MediaQuery.of(context).size.width * .03,
                    right: MediaQuery.of(context).size.width * .03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: orderStatus.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          getOrder(orderStatus[index].id);
                          setState(() {
                            SelectedCategory = orderStatus[index].id;
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.only(
                              right: index == 0
                                  ? MediaQuery.of(context).size.width * .05
                                  : 0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 0,
                                    ),
                                    Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          orderStatus[index].name,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: SelectedCategory ==
                                                      orderStatus[index].id
                                                  ? Color(h.mainColor)
                                                  : Colors.black54,
                                              fontSize: 14),
                                          textAlign: TextAlign.center,
                                        )),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .06,
                                    ),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                              ],
                            )),
                      );
                    }),
              ),
              orders == null
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(h.mainColor),
                        ),
                      ),
                    )
                  : orders.length > 0
                      ? Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * .0,
                                  bottom:
                                      MediaQuery.of(context).size.height * .04),
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    print("done");
                                    orderServices.getOrderDetails(
                                            orders[index].orderID.toString())
                                        .then((value) {
                                      Navigator.push(
                                        context,
                                        GlobalFunction.route(
                                          OrderDetailsScreen(
                                            orderDetails: value,
                                            order: orders[index],
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          .01,
                                      right: MediaQuery.of(context).size.width *
                                          .05,
                                      left: MediaQuery.of(context).size.width *
                                          .05,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                          color:
                                              Colors.black12.withOpacity(.08),
                                          width: 1),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.black12.withOpacity(0.03),
                                          spreadRadius: 4,
                                          blurRadius: 4,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.only(
                                              right: 10,
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .015,
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .01,
                                              left: 0,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            "images/food_logo.png",
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .225,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .225,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            width: 150,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  DemoLocalizations.of(context).title['requestnumber'] + ' ' +
                                                                      orders[index].orderNumber.toString(),
                                                                  style: TextStyle(
                                                                      height: 1.5,
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Color(h.mainColor)),
                                                                ),
                                                                // SizedBox(
                                                                //   height: 3,
                                                                // ),
                                                                // Text(
                                                                //     DemoLocalizations.of(context).title[
                                                                //             'productsnumber'] +
                                                                //         " : ${orders[index].allQuantity}",
                                                                //     style: TextStyle(
                                                                //         height:
                                                                //             1.5,
                                                                //         fontSize:
                                                                //             13,
                                                                //         color: Colors
                                                                //             .black38)),
                                                                SizedBox(
                                                                  height: 3,
                                                                ),
                                                                Text(
                                                                    DemoLocalizations.of(context).title[
                                                                            'ordertime'] +
                                                                        ' :  ${DateFormat('MM/dd  h:mm a').format(DateTime.parse(orders[index].orderDate))}',
                                                                    style: TextStyle(
                                                                        height:
                                                                            1.5,
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black54)),
                                                                SizedBox(
                                                                  height: 3,
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          .64 -
                                                                      10,
                                                                  child: Text(
                                                                    //
                                                                    DemoLocalizations.of(context).title[
                                                                            'Total'] +
                                                                        // '${(orders[index].subTotal + orders[index].deliveryValue).substring(0, 5)}' +
                                                                        // ' : ${(orders[index].subTotal + orders[index].deliveryValue - orders[index].discount)} '
                                                                        ' : ${(orders[index].totalValue)} ' +
                                                                        DemoLocalizations.of(context)
                                                                            .title['currency'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SelectedCategory == '1'
                                                        ? Container(
                                                            child: Row(
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        DeleteFromCart(
                                                                            context,
                                                                            index);
                                                                        print(
                                                                            'Cancel Order');
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .delete_forever_rounded,
                                                                        size:
                                                                            40,
                                                                        color: Colors
                                                                            .redAccent,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      DemoLocalizations.of(
                                                                              context)
                                                                          .title['cancelOrder'],
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : Expanded(
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * .1),
                              child: Center(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "images/orders.png",
                                      color: Colors.black26,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .25,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .035,
                                    ),
                                    Text(
                                      //nologdata

                                      DemoLocalizations.of(context)
                                          .title['nologdata'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black26),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .035,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            GlobalFunction.route(HomePage()));
                                      },
                                      child: DottedBorder(
                                          color: Colors.black26,
                                          strokeWidth: 1.5,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .6,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .05,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              //  border: Border.all(width: 1.0,color: Colors.black26)
                                            ),
                                            child: Text(
                                              DemoLocalizations.of(context)
                                                  .title['shopnow'],
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              )),
                        )
            ],
          ),
        ),
      ),
    );
  }

  DeleteFromCart(BuildContext context, int index) {
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
                            .title['Doyouwanttocancelorder'],
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
                                color: Color(h.mainColor)),
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
                                color: Colors.green),
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
                              orderServices.cancelOrder(orders[index].orderID);
                            });
                            // addProductDialog(context);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (_) => HomePage(
                                          index: 0,
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

  addProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 150.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              border: Border.all(color: Colors.black12, width: 2.0),
              color: Colors.white),
          child: Stack(
            children: <Widget>[
              Column(
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
                            DemoLocalizations.of(context).title['adddone'],
                            style: TextStyle(
                                color: Color(h.blueColor),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          // Text(
                          //   DemoLocalizations.of(context).title['qunt'] +
                          //       "$count",
                          //   style: TextStyle(
                          //       fontSize: 14, fontWeight: FontWeight.bold),
                          //   textAlign: TextAlign.center,
                          // ),
                          // Text("${title}",textAlign: TextAlign.center,)
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
}
