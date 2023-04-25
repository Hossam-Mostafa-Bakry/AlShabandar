import 'package:mishwar/Model/BranchModel.dart';
import 'package:mishwar/Model/RegionModel.dart';
import 'package:mishwar/Screens/DelveryUser/getDeliveryValueProvider.dart';
import 'package:mishwar/Screens/DelveryUser/getbranch.dart';
import 'package:mishwar/Screens/confirmedorderui/second_step_address.dart';
import 'package:mishwar/app/Services/AddressServices.dart';
import 'package:mishwar/app/Services/ConfigServices.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:mishwar/main.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:mishwar/Screens/shared/button_ui.dart';
import 'package:mishwar/Screens/confirmedorderui/fourth_step_payment.dart';
import 'package:mishwar/Screens/HomePage.dart';
import 'package:mishwar/app/AppConfig.dart';

import 'first_step_user_data.dart';

class ThirdStepDelivery extends StatefulWidget {
  @override
  _ThirdStepDeliveryState createState() => _ThirdStepDeliveryState();
}

class _ThirdStepDeliveryState extends State<ThirdStepDelivery> {
  home h = new home();
  String delevery;
  double deliveryValue = 0.0;
  String branchId;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<RegionDetail> RegionList = [];
  List<RegionDetail> RegionList0 = [];
  List<BranchModelDetail> branchList = [];
  List<BranchModelDetail> branchList0 = [];
  AddressServices addressServices = new AddressServices();
  ConfigServices configServices = ConfigServices();

  String SelectedRegion;
  String SelectedRegionId = '';

  String selectedBranch;
  String selectedBranchId = '0';

  TextEditingController searchzone = new TextEditingController();

  loadBranchData() async {
    branchList0 = await configServices.GetBranches();
    setState(() {
      branchList = branchList0;
    });
  }

  loadData() async {
    RegionList0 = await addressServices.GetRegions();
    setState(() {
      RegionList = RegionList0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    loadBranchData();
    deliveryValue =
        Provider.of<GetDeliveryValueProvider>(context, listen: false)
            .priceDelivery;
    // branchId = Provider.of<GetUserBranch>(context, listen: false).branchId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          (Route<dynamic> route) => false,
        );

        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
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
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).size.width * 0.05),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.05,
                    bottom: MediaQuery.of(context).size.width * 0.05,
                    left: MediaQuery.of(context).size.width * 0.025,
                    right: MediaQuery.of(context).size.width * 0.025),
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
                                Icons.local_shipping_rounded,
                                color: Colors.white,
                                size: 20.0,
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
                                DemoLocalizations.of(context).title['Delivery'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                textAlign: TextAlign.right),
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
                                Icons.payment,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  color: Colors.grey, shape: BoxShape.circle),
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
                                  color: Colors.grey, shape: BoxShape.circle),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(DemoLocalizations.of(context).title['confirm'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                textAlign: TextAlign.center),
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
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .25,
                    height: MediaQuery.of(context).size.width * .25,
                    child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1000)),
                            border:
                                Border.all(color: Color(h.blueColor), width: 3),
                            color: Colors.white),
                        padding: EdgeInsets.all(15),
                        child: ImageIcon(
                          AssetImage("images/inWay.png"),
                          size: 35,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .0005,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .01,
                        bottom: MediaQuery.of(context).size.height * .01,
                        left: MediaQuery.of(context).size.width * .05,
                        right: MediaQuery.of(context).size.width * .05),

                    alignment: Alignment.center,
                    //Deliverymethod
                    child: Text(
                      DemoLocalizations.of(context).title['Deliverymethod'],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * .9,
                    color: Colors.black26,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: Colors.black12.withOpacity(.1),
                          width: 1,
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * .02,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(context, GlobalFunction.route(PaymentMethod()));

                              setState(() {
                                delevery = "delivery1";
                              });

                              SelectRegion(context);
                              Provider.of<GetDeliveryValueProvider>(context,
                                      listen: false)
                                  .getDeliveryValue(0.0);

                              print(
                                  '333=${Provider.of<GetDeliveryValueProvider>(context, listen: false).priceDelivery}');
                              print(
                                  '333=${Provider.of<GetDeliveryValueProvider>(context, listen: false).priceDelivery}');

                              appConfig.prefs.setString(
                                'delmethodtext',
                                DemoLocalizations.of(context)
                                    .title['Receiptfromthebranch'],
                              );

                              appConfig.prefs.setString('delcost', '0');
                              appConfig.prefs.setInt('delmethodvalue', 1);
                            },
                            child: Container(
                              height: 30,
                              // color: Colors.red,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Radio(
                                    activeColor: Color(h.mainColor),
                                    value: "delivery1",
                                    groupValue: delevery,
                                    onChanged: (String value) {
                                      setState(() {
                                        delevery = value;
                                      });
                                      SelectRegion(context);
                                      // selectBranchFormBootomShet(context);
                                      Provider.of<GetDeliveryValueProvider>(
                                              context,
                                              listen: false)
                                          .getDeliveryValue(0.0);
                                      print(
                                          '333=${Provider.of<GetDeliveryValueProvider>(context, listen: false).priceDelivery}');
                                      print(
                                          '333=${Provider.of<GetDeliveryValueProvider>(context, listen: false).priceDelivery}');
                                      appConfig.prefs.setString(
                                          'delmethodtext',
                                          DemoLocalizations.of(context)
                                              .title['Receiptfromthebranch']);
                                      appConfig.prefs.setString('delcost', '0');
                                      appConfig.prefs
                                          .setInt('delmethodvalue', 1);
                                    },
                                    //Receiptfromthebranch
                                  ),
                                  Text(
                                    DemoLocalizations.of(context)
                                        .title['Receiptfromthebranch'],
                                    maxLines: 1,
                                    style: TextStyle(
                                        height: 1,
                                        color: Colors.black,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Divider(
                            color: Colors.black12.withOpacity(.1),
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(context, GlobalFunction.route(SearchLocation()));
                              setState(() {
                                delevery = "delivery2";
                              });

                              Provider.of<GetDeliveryValueProvider>(context,
                                      listen: false)
                                  .getDeliveryValue(deliveryValue);
                              print(
                                  '333=${Provider.of<GetDeliveryValueProvider>(context, listen: false).priceDelivery}');
                              appConfig.prefs.setString(
                                  'delmethodtext',
                                  DemoLocalizations.of(context)
                                      .title['Deliveryfromthebranch']);
                              appConfig.prefs.setInt('delmethodvalue', 2);
                              appConfig.prefs.setString('delcost', '0');
                            },
                            child: Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Radio(
                                      activeColor: Color(h.mainColor),
                                      value: "delivery2",
                                      groupValue: delevery,
                                      onChanged: (String value) {
                                        setState(() {
                                          delevery = value;
                                        });
                                        // selectedBranchId = '0';
                                        Provider.of<GetDeliveryValueProvider>(
                                                context,
                                                listen: false)
                                            .getDeliveryValue(deliveryValue);
                                        print(
                                            '333=${Provider.of<GetDeliveryValueProvider>(context, listen: false).priceDelivery}');
                                        appConfig.prefs.setString(
                                            'delmethodtext',
                                            DemoLocalizations.of(context).title[
                                                'Deliveryfromthebranch']);
                                        appConfig.prefs
                                            .setInt('delmethodvalue', 2);
                                        appConfig.prefs
                                            .setString('delcost', '0');
                                      },
                                    ),
                                    Text(
                                        DemoLocalizations.of(context)
                                            .title['Deliveryfromthebranch'],
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12)),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Divider(
                            color: Colors.black12.withOpacity(.1),
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(context, GlobalFunction.route(SearchLocation()));
                              setState(() {
                                delevery = "delivery3";
                              });
                              SelectRegion(context);
                              Provider.of<GetDeliveryValueProvider>(context,
                                      listen: false)
                                  .getDeliveryValue(0.0);
                              print(
                                  '333=${Provider.of<GetDeliveryValueProvider>(context, listen: false).priceDelivery}');
                              appConfig.prefs.setString(
                                  'delmethodtext',
                                  DemoLocalizations.of(context)
                                      .title['familyonbranch']);
                              appConfig.prefs.setInt('delmethodvalue', 3);
                              appConfig.prefs.setString('delcost', '0');
                            },
                            child: Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Radio(
                                      activeColor: Color(h.mainColor),
                                      value: "delivery3",
                                      groupValue: delevery,
                                      onChanged: (String value) {
                                        setState(() {
                                          delevery = value;
                                        });
                                        SelectRegion(context);
                                        Provider.of<GetDeliveryValueProvider>(
                                                context,
                                                listen: false)
                                            .getDeliveryValue(0.0);
                                        print(
                                            '333=${Provider.of<GetDeliveryValueProvider>(context, listen: false).priceDelivery}');
                                        appConfig.prefs.setString(
                                            'delmethodtext',
                                            DemoLocalizations.of(context)
                                                .title['familyonbranch']);
                                        appConfig.prefs
                                            .setInt('delmethodvalue', 3);
                                        appConfig.prefs
                                            .setString('delcost', '0');
                                      },
                                    ),
                                    Text(
                                        DemoLocalizations.of(context)
                                            .title['familyonbranch'],
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12)),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Divider(
                            color: Colors.black12.withOpacity(.1),
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(context, GlobalFunction.route(SearchLocation()));
                              setState(() {
                                delevery = "delivery4";
                              });
                              SelectRegion(context);
                              Provider.of<GetDeliveryValueProvider>(context,
                                      listen: false)
                                  .getDeliveryValue(0.0);
                              print(
                                  '333=${Provider.of<GetDeliveryValueProvider>(context, listen: false).priceDelivery}');
                              appConfig.prefs.setString(
                                  'delmethodtext',
                                  DemoLocalizations.of(context)
                                      .title['dayingonbranch']);
                              appConfig.prefs.setInt('delmethodvalue', 3);
                              appConfig.prefs.setString('delcost', '0');
                            },
                            child: Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Radio(
                                      activeColor: Color(h.mainColor),
                                      value: "delivery4",
                                      groupValue: delevery,
                                      onChanged: (String value) {
                                        setState(() {
                                          delevery = value;
                                        });
                                        SelectRegion(context);
                                        Provider.of<GetDeliveryValueProvider>(
                                                context,
                                                listen: false)
                                            .getDeliveryValue(0.0);
                                        print(
                                            '333=${Provider.of<GetDeliveryValueProvider>(context, listen: false).priceDelivery}');
                                        appConfig.prefs.setString(
                                            'delmethodtext',
                                            DemoLocalizations.of(context)
                                                .title['dayingonbranch']);
                                        appConfig.prefs
                                            .setInt('delmethodvalue', 3);
                                        appConfig.prefs
                                            .setString('delcost', '0');
                                      },
                                    ),
                                    Text(
                                        DemoLocalizations.of(context)
                                            .title['dayingonbranch'],
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12)),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                        ],
                      )),
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: 0.0,
                ),
              ),
              ButtonUi(
                widget: Text(
                  DemoLocalizations.of(context).title['next'],
                  style: TextStyle(color: Colors.white),
                ),
                backColor: Color(h.blueColor),
                function: () {
                  if (delevery == null) {
                    Toast.show(
                      // Pleasechooseadeliverymethod
                      DemoLocalizations.of(context).title['Pleasechooseadeliverymethod'],
                      context,
                      duration: Toast.LENGTH_SHORT,
                      gravity: Toast.BOTTOM,
                    );
                  } else {
                    Provider.of<GetUserBranch>(context, listen: false)
                        .getBranchValue(selectedBranch, selectedBranchId);
                    print(
                        ' BranchId : ${Provider.of<GetUserBranch>(context, listen: false).branchId}');
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            FourthStepPayment(),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  }
                },
                doubleValue: MediaQuery.of(context).size.width - 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  // selectBranchFormBootomShet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) => Container(
  //       alignment: Alignment.center,
  //       width: MediaQuery.of(context).size.width * .4,
  //       decoration: BoxDecoration(
  //         color: Colors.black12,
  //         // borderRadius: BorderRadius.all(Radius.circular(20))
  //         // border: Border.all(color: Colors.black12,width: 2.0)
  //       ),
  //       padding: EdgeInsets.only(
  //         top: MediaQuery.of(context).size.height * 0.01,
  //         bottom: MediaQuery.of(context).size.height * 0.01,
  //         left: MediaQuery.of(context).size.width * 0.05,
  //         right: MediaQuery.of(context).size.width * 0.05,
  //       ),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             SizedBox(
  //               height: 5,
  //             ),
  //             Container(
  //               width: MediaQuery.of(context).size.width * .66,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.all(Radius.circular(10)),
  //               ),
  //               child: TextFormField(
  //                 keyboardType: TextInputType.text,
  //                 onChanged: (val) {
  //                   if (val.isNotEmpty) {
  //                     setState(() {
  //                       RegionList = [];
  //                     });
  //                     for (int i = 0; i < RegionList0.length; i++) {
  //                       setState(() {
  //                         if (RegionList0[i].region.contains(val)) {
  //                           RegionList.add(RegionList0[i]);
  //                         }
  //                       });
  //                       // FocusScope.of(context).requestFocus(FocusNode());
  //                       setState(() {});
  //                     }
  //                     print(RegionList.length);
  //                     print(
  //                         "1111111111111111111111111111111111111111111111111111");
  //                   } else {
  //                     setState(() {
  //                       RegionList = RegionList0;
  //                     });
  //                   }
  //                 },
  //                 onFieldSubmitted: (value) {
  //                   FocusScope.of(context).requestFocus(FocusNode());
  //                 },
  //                 validator: (value) {
  //                   if (value.isEmpty) {
  //                     return null;
  //                   }
  //                   return null;
  //                 },
  //                 textAlign: TextAlign.end,
  //                 decoration: InputDecoration(
  //                     errorStyle: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 12,
  //                         color: Color(h.mainColor)),
  //                     contentPadding: EdgeInsets.only(
  //                         right: 10, left: 10, top: 0, bottom: 0),
  //                     enabledBorder: new OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                         borderSide: BorderSide(color: Colors.black38)),
  //                     focusedBorder: new OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                         borderSide:
  //                             BorderSide(color: Color(h.FocusBorderColor))),
  //                     focusedErrorBorder: new OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                         borderSide:
  //                             BorderSide(color: Color(h.ErorrBorderColor))),
  //                     errorBorder: new OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                         borderSide:
  //                             BorderSide(color: Color(h.ErorrBorderColor))),
  //                     prefixIcon: Icon(
  //                       Icons.search,
  //                       size: 20,
  //                       color: Colors.black45,
  //                     ),
  //                     hintText: 'ابحث',
  //                     hintStyle: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 12,
  //                         color: Colors.black45)),
  //                 controller: searchzone,
  //               ),
  //             ),
  //             SizedBox(
  //               height: 5,
  //             ),
  //             ListView.builder(
  //               shrinkWrap: true,
  //               primary: false,
  //               itemCount: RegionList.length,
  //               itemBuilder: (context, index) {
  //                 return GestureDetector(
  //                   onTap: () async {
  //                     setState(() {
  //                       SelectedRegion = RegionList[index].region;
  //                       SelectedRegionId = RegionList[index].id;
  //                     });
  //
  //                     Navigator.pop(context);
  //                   },
  //                   child: Container(
  //                       margin: EdgeInsets.only(
  //                           bottom: MediaQuery.of(context).size.height * .005,
  //                           top: MediaQuery.of(context).size.height * .005),
  //                       padding: EdgeInsets.only(
  //                           bottom: MediaQuery.of(context).size.height * .005,
  //                           top: MediaQuery.of(context).size.height * .005),
  //                       decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.all(Radius.circular(5)),
  //                           color: Color(h.blueColor)),
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         RegionList[index].region,
  //                         style: TextStyle(color: Colors.white),
  //                       )),
  //                 );
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  SelectRegion(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                width: MediaQuery.of(context).size.width * .4,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  // borderRadius: BorderRadius.all(Radius.circular(20))
                  // border: Border.all(color: Colors.black12,width: 2.0)
                ),
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  bottom: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .66,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              setState(() {
                                branchList = [];
                              });
                              for (int i = 0; i < branchList0.length; i++) {
                                setState(() {
                                  if (branchList0[i].name.contains(val)) {
                                    branchList.add(branchList0[i]);
                                  }
                                });
                                // FocusScope.of(context).requestFocus(FocusNode());
                                setState(() {});
                              }
                              print(branchList.length);
                              print(
                                  "1111111111111111111111111111111111111111111111111111");
                            } else {
                              setState(() {
                                branchList = branchList0;
                              });
                            }
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return null;
                            }
                            return null;
                          },
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(h.mainColor)),
                            contentPadding: EdgeInsets.only(
                                right: 10, left: 10, top: 0, bottom: 0),
                            enabledBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black38)),
                            focusedBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(h.FocusBorderColor))),
                            focusedErrorBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(h.ErorrBorderColor))),
                            errorBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(h.ErorrBorderColor))),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 20,
                              color: Colors.black45,
                            ),
                            hintText: 'ابحث',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black45,
                            ),
                          ),
                          controller: searchzone,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: branchList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              setState(() {
                                selectedBranch = branchList[index].name;
                                selectedBranchId = branchList[index].branchId;
                              });
                              print(
                                  'branch $selectedBranch  branch $selectedBranchId');

                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height * .005,
                                  top: MediaQuery.of(context).size.height *
                                      .005),
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height * .005,
                                  top: MediaQuery.of(context).size.height *
                                      .005),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Color(h.blueColor)),
                              alignment: Alignment.center,
                              child: Text(
                                branchList[index].name,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
