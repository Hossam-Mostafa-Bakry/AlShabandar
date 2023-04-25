import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mishwar/Screens/shared/button_ui.dart';
import 'package:mishwar/Screens/slmlmProvider.dart';
import 'package:mishwar/Screens/subofferItem.dart';
import 'package:mishwar/app/AppConfig.dart';
import 'package:mishwar/app/Services/ProductServices.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Model/BranchModel.dart';
import '../Model/CartModelLocal.dart';
import '../Model/FavouriteLocalModel.dart';
import '../Model/RegionModel.dart';
import '../Model/cart_model.dart';
import '../Services/database_helper.dart';
import '../Services/snackbar_service.dart';
import '../app/Services/AddressServices.dart';
import '../app/Services/ConfigServices.dart';
import '../dbHelper.dart';
import '../Model/ProductModel.dart';
import '../Model/SubProductModel.dart';
import '../main.dart';
import 'DelveryUser/getDeliveryValueProvider.dart';
import 'DelveryUser/getbranch.dart';
import 'add_on_items.dart';
import 'main_provider.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<MainPage> {
  int selectedIndex = 0;

  final formKey = GlobalKey<FormState>();
  DbHelper dbHelper = new DbHelper();

  String delevery;
  double deliveryValue = 0.0;
  String SelectedRegion;
  String SelectedRegionId = '';
  String selectedBranch;
  String selectedBranchId = '0';
  List<RegionDetail> RegionList = [];
  List<RegionDetail> RegionList0 = [];
  List<BranchModelDetail> branchList = [];
  List<BranchModelDetail> branchList0 = [];
  AddressServices addressServices = new AddressServices();
  ConfigServices configServices = ConfigServices();
  TextEditingController searchzone = new TextEditingController();

  TextEditingController message = new TextEditingController();

  String noteMessage = '';
  List<SubProductDetail> subProduct = [];
  var i = 0;
  home h = new home();

  MainProvider provider;

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
    loadData();
    loadBranchData();
    productServices.getCategory();
    productServices.getProduct('1', '1');
    deliveryValue =
        Provider.of<GetDeliveryValueProvider>(context, listen: false)
            .priceDelivery;

    Future.delayed(Duration(seconds: 0)).then((_) {
      if (Provider.of<MainProvider>(context, listen: false)
              .selectDeliveryType ==
          false) {
        showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: StatefulBuilder(builder: (context, setState) {
              return Container(
                padding: EdgeInsets.all(14),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .20,
                      height: MediaQuery.of(context).size.width * .20,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(h.blueColor),
                              width: 3,
                            ),
                            color: Colors.white),
                        padding: EdgeInsets.all(15),
                        child: ImageIcon(
                          AssetImage("images/inWay.png"),
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .0005,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .01,
                        bottom: MediaQuery.of(context).size.height * .01,
                        left: MediaQuery.of(context).size.width * .05,
                        right: MediaQuery.of(context).size.width * .05,
                      ),
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
                              offset:
                                  Offset(3, 3), // changes position of shadow
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
                                        appConfig.prefs
                                            .setString('delcost', '0');
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
                                      .title['Deliveryfromthebranch'],
                                );
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
                                              DemoLocalizations.of(context)
                                                      .title[
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
                                              color: Colors.black,
                                              fontSize: 12)),
                                    ],
                                  )),
                            ),
                            // SizedBox(
                            //   height: 0,
                            // ),
                            // Divider(
                            //   color: Colors.black12.withOpacity(.1),
                            //   thickness: 1,
                            // ),
                            // SizedBox(
                            //   height: 0,
                            // ),
                            // GestureDetector(
                            //   onTap: () {
                            //     // Navigator.push(context, GlobalFunction.route(SearchLocation()));
                            //     setState(() {
                            //       delevery = "delivery3";
                            //     });
                            //     SelectRegion(context);
                            //     Provider.of<GetDeliveryValueProvider>(context,
                            //             listen: false)
                            //         .getDeliveryValue(0.0);
                            //     print(
                            //         '333=${Provider.of<GetDeliveryValueProvider>(context, listen: false).priceDelivery}');
                            //     appConfig.prefs.setString(
                            //         'delmethodtext',
                            //         DemoLocalizations.of(context)
                            //             .title['familyonbranch']);
                            //     appConfig.prefs.setInt('delmethodvalue', 3);
                            //     appConfig.prefs.setString('delcost', '0');
                            //   },
                            //   child: Container(
                            //       height: 30,
                            //       child: Row(
                            //         children: [
                            //           SizedBox(
                            //             width: 10,
                            //           ),
                            //           Radio(
                            //             activeColor: Color(h.mainColor),
                            //             value: "delivery3",
                            //             groupValue: delevery,
                            //             onChanged: (String value) {
                            //               setState(() {
                            //                 delevery = value;
                            //               });
                            //               SelectRegion(context);
                            //               Provider.of<GetDeliveryValueProvider>(
                            //                       context,
                            //                       listen: false)
                            //                   .getDeliveryValue(0.0);
                            //               print(
                            //                   '333=${Provider.of<GetDeliveryValueProvider>(context, listen: false).priceDelivery}');
                            //               appConfig.prefs.setString(
                            //                   'delmethodtext',
                            //                   DemoLocalizations.of(context)
                            //                       .title['familyonbranch']);
                            //               appConfig.prefs
                            //                   .setInt('delmethodvalue', 3);
                            //               appConfig.prefs.setString('delcost', '0');
                            //             },
                            //           ),
                            //           Text(
                            //               DemoLocalizations.of(context)
                            //                   .title['familyonbranch'],
                            //               maxLines: 1,
                            //               style: TextStyle(
                            //                   color: Colors.black, fontSize: 12)),
                            //         ],
                            //       )),
                            // ),
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
                                              color: Colors.black,
                                              fontSize: 12)),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 0,
                            ),
                          ],
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    ButtonUi(
                      widget: Text(
                        DemoLocalizations.of(context).title['confirm'],
                        style: TextStyle(color: Colors.white),
                      ),
                      backColor: Color(h.blueColor),
                      function: () {
                        if (delevery == null) {
                          Toast.show(
                              // Pleasechooseadeliverymethod
                              DemoLocalizations.of(context)
                                  .title['Pleasechooseadeliverymethod'],
                              context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        } else {
                          Provider.of<GetUserBranch>(context, listen: false)
                              .getBranchValue(selectedBranch, selectedBranchId);
                          print(
                              ' BranchId : ${Provider.of<GetUserBranch>(context, listen: false).branchId}');
                          Provider.of<MainProvider>(context, listen: false)
                              .setDeliveryType(true);
                          Navigator.pop(context);
                        }
                      },
                      doubleValue: MediaQuery.of(context).size.width - 20,
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Observer(
      builder: (_) => WillPopScope(
        onWillPop: () async {
          confirmCloseApp(context);
          return true;
        },
        child: Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(left: 6, right: 6, top: 10),
            padding: EdgeInsets.only(left: 4, right: 4, top: 8),
            decoration: BoxDecoration(
                // color: Colors.red.withOpacity(1),
                ),
            child: Column(
              children: [
                ClipRRect(
                  child: Image.asset(
                    "images/header_image.jpg",
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Container(
                  height: 120,
                  child: !appConfig.dApp.loadCategory
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : appConfig.dApp.mainCategoryList.isNotEmpty
                          ? ListView.builder(
                              padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * .03,
                                left: MediaQuery.of(context).size.width * .03,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: appConfig.dApp.mainCategoryList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    selectedIndex = index;
                                    appConfig.dApp.setSelectedCategory(
                                      appConfig.dApp.mainCategoryList[index],
                                    );
                                    productServices.getProduct(
                                      appConfig.dApp.mainCategoryList[index].id,
                                      '1',
                                    );
                                    setState(() {});
                                    print(
                                      '${appConfig.dApp.selectedCategory == appConfig.dApp.mainCategoryList[index].id}',
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Card(
                                        elevation:
                                            selectedIndex == index ? 5 : 0,
                                        // elevation: appConfig.dApp.selectedCategory == appConfig.dApp.mainCategoryList[index].id
                                        //         ? 5
                                        //         : 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                        ),
                                        color: Colors.grey.shade200,
                                        margin:
                                            EdgeInsets.only(left: 7, right: 7),
                                        child: Container(
                                          height: 110,
                                          width: 56.5,
                                          padding: EdgeInsets.only(
                                            // top: 5,
                                            left: 2,
                                            right: 2,
                                          ),
                                          margin: EdgeInsets.only(
                                            left: 4,
                                            right: 4,
                                          ),
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 55,
                                                height: 55,
                                                margin: EdgeInsets.only(top: 8),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(h.mainColor),
                                                      width: 2),
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 5,
                                                    ),
                                                  ],
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  child: appConfig
                                                              .dApp
                                                              .mainCategoryList[
                                                                  index]
                                                              .image ==
                                                          null
                                                      ? Image.asset(
                                                          "images/no-img.jpg",
                                                          width: 45,
                                                          height: 45,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : FadeInImage
                                                          .assetNetwork(
                                                          placeholder:
                                                              "images/Spinner.gif",
                                                          image: appConfig
                                                                      .dApp
                                                                      .mainCategoryList[
                                                                          index]
                                                                      .image ==
                                                                  null
                                                              ? ""
                                                              : appConfig
                                                                  .dApp
                                                                  .mainCategoryList[
                                                                      index]
                                                                  .image,
                                                          width: 45,
                                                          height: 45,
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Container(
                                                height: 35,
                                                child: Text(
                                                  appConfig
                                                      .dApp
                                                      .mainCategoryList[index]
                                                      .name,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      height: 1.2,
                                                      color: Colors.black,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                DemoLocalizations.of(context)
                                    .title['nologdata'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .005,
                ),
                !appConfig.dApp.loadProducts
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : appConfig.dApp.mainProductsList.isEmpty
                        ? Expanded(
                            child: Center(
                              child: Text(
                                DemoLocalizations.of(context)
                                    .title['nologdata'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          )
                        // Food Grid View
                        : Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.85,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 5,
                              ),
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .01,
                                left: MediaQuery.of(context).size.height * .012,
                                right:
                                    MediaQuery.of(context).size.height * .012,
                                bottom:
                                    MediaQuery.of(context).size.height * .03,
                              ),
                              itemCount: appConfig.dApp.mainProductsList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    ProductDetails2(
                                      appConfig.dApp.mainProductsList[index],
                                      appConfig.dApp.mainProductsList[index]
                                          .promotionItems,
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        .125,
                                    margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              .01,
                                      left: MediaQuery.of(context).size.width *
                                          .0125,
                                      right: MediaQuery.of(context).size.width *
                                          .0125,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                            child: appConfig
                                                        .dApp
                                                        .mainProductsList[index]
                                                        .image ==
                                                    null
                                                ? Image.asset(
                                                    "images/no-img.jpg",
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.125,
                                                    fit: BoxFit.cover,
                                                  )
                                                : FadeInImage.assetNetwork(
                                                    placeholder:
                                                        "images/Spinner.gif",
                                                    image: appConfig
                                                                .dApp
                                                                .mainProductsList[
                                                                    index]
                                                                .image ==
                                                            null
                                                        ? ""
                                                        : appConfig
                                                            .dApp
                                                            .mainProductsList[
                                                                index]
                                                            .image,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .125,
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .59,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .28,
                                                    child: Text(
                                                      '${appConfig.dApp.mainProductsList[index].name}',
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        height: 1.25,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Transform.rotate(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      child: Container(
                                                        width: 25,
                                                        height: 25,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: Color(
                                                              h.mainColor),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Transform.rotate(
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 16,
                                                            color: Colors.black,
                                                          ),
                                                          angle: 181.35,
                                                        ),
                                                      ),
                                                    ),
                                                    angle: 181.46,
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                appConfig
                                                            .dApp
                                                            .mainProductsList[
                                                                index]
                                                            .description ==
                                                        null
                                                    ? "Product Description"
                                                    : appConfig
                                                        .dApp
                                                        .mainProductsList[index]
                                                        .description,
                                                style: TextStyle(
                                                  height: 1.0,
                                                  fontSize: 10,
                                                  color: Colors.black38,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                //currency
                                                "${appConfig.dApp.mainProductsList[index].price2} " +
                                                    DemoLocalizations.of(
                                                            context)
                                                        .title['currency'],
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final db = DatabaseHelper();

  Widget ProductDetails2(ProductDetail product, List<SubProductDetail1> data) {
    print(data.length);
    print("dddddddddddddddddddddd");
    Provider.of<SlmlmProvider>(context, listen: false).clear();

    Provider.of<SlmlmProvider>(context, listen: false).a7a(
      quantityParm: 1,
      quantityOfferParm: 0,
    );
    int quantity = Provider.of<SlmlmProvider>(context, listen: false).quantity;
    int quantityOffer =
        Provider.of<SlmlmProvider>(context, listen: false).quantityOffer;

    print(
        '55555=${Provider.of<SlmlmProvider>(context, listen: false).quantityOffer}');

    double totalPrice = double.parse(product.price2) * quantity;

    double totalPriceOffer = 0.0;
    double subItemTotalPrice = 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Scaffold(
          persistentFooterButtons: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      DemoLocalizations.of(context).title['Total'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                    ),
                    Consumer<SlmlmProvider>(
                      builder: (context, ch, _) => Text(
                        "${double.parse(product.price2) * ch.quantity + Provider.of<SlmlmProvider>(context, listen: false).totalPriceOffer}" +
                            DemoLocalizations.of(context).title['currency'],
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  height: MediaQuery.of(context).size.height * .06,
                  width: MediaQuery.of(context).size.width * .4,
                  child: GestureDetector(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(h.blueColor),
                        ),
                        height: MediaQuery.of(context).size.height * .125,
                        // width: MediaQuery.of(context).size.width * .3,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * .0,
                          bottom: MediaQuery.of(context).size.width * .0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: 8),
                            Text(
                              DemoLocalizations.of(context).title['addtocart'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                          ],
                        )),
                    onTap: () async {
                      if (Provider.of<SlmlmProvider>(context, listen: false)
                              .quantity >=
                          Provider.of<SlmlmProvider>(context, listen: false)
                              .quantityAddOnItems) {
                        final cart = CartModel(
                          id: int.parse(product.id),
                          name: product.name,
                          img: product.image,
                          description: product.description,
                          price: double.parse(product.price),
                          offerPrice:
                              Provider.of<SlmlmProvider>(context, listen: false)
                                  .totalPriceOffer,
                          price2: double.parse(product.price2),
                          totalPrice: double.parse(product.price2) *
                                  Provider.of<SlmlmProvider>(context,
                                          listen: false)
                                      .quantity +
                              Provider.of<SlmlmProvider>(context, listen: false)
                                  .totalPriceOffer,
                          quantity:
                              Provider.of<SlmlmProvider>(context, listen: false)
                                  .quantity,
                          selectedTypeName: 'mainProduct',
                          offerName:
                              Provider.of<SlmlmProvider>(context, listen: false)
                                  .totalofferNames,
                          message: noteMessage,
                          subItems:
                              Provider.of<SlmlmProvider>(context, listen: false)
                                  .subItemsList,
                        );

                        // final jsonString = jsonEncode(cart.toJson());
                        // await db.insertModel(jsonString as Map<String, dynamic>);

                        print(cart.toJson());
                        // await db.insertModel(cart.toJson());
                        // await dbHelper.addToCartTable(cart);

                        try {
                          Navigator.pop(context);
                          Provider.of<SlmlmProvider>(context, listen: false)
                              .setAddOnItemQuantity(0);
                          addProductDialog(
                            context,
                            Provider.of<SlmlmProvider>(context, listen: false)
                                .quantity,
                          );
                          await dbHelper.addToCartTable(cart);
                          Provider.of<SlmlmProvider>(context, listen: false)
                              .subItemsList = [];
                        } catch (e) {
                          Navigator.pop(context);
                          addProductDialog(
                              context,
                              Provider.of<SlmlmProvider>(context, listen: false)
                                  .quantity);
                          dbHelper.updateCourseTable(cart);
                          Provider.of<SlmlmProvider>(context, listen: false)
                              .subItemsList = [];
                        }
                      } else {
                        print("you can'/t");
                        SnackBarService.showErrorMessage(
                            DemoLocalizations.of(context)
                                .title['subItemMorethanMainItem']);
                      }

                      // if (Provider.of<SlmlmProvider>(context, listen: false)
                      //         .quantity >=
                      //     Provider.of<SlmlmProvider>(context, listen: false)
                      //         .quantityAddOnItems) {
                      //   CartMedelLocal p1 = new CartMedelLocal({
                      //     "id": int.parse(product.id),
                      //     "name": product.name,
                      //     "img": product.image,
                      //     "description": product.description,
                      //     "price": double.parse(product.price),
                      //     "offerPrice":
                      //         Provider.of<SlmlmProvider>(context, listen: false)
                      //             .totalPriceOffer,
                      //     "price2": double.parse(product.price2),
                      //     "totalPrice": double.parse(product.price2) *
                      //             Provider.of<SlmlmProvider>(context,
                      //                     listen: false)
                      //                 .quantity +
                      //         Provider.of<SlmlmProvider>(context, listen: false)
                      //             .totalPriceOffer,
                      //     "quantity":
                      //         Provider.of<SlmlmProvider>(context, listen: false)
                      //             .quantity,
                      //     "selectedTypeName": 'mainProduct',
                      //     "offerName":
                      //         Provider.of<SlmlmProvider>(context, listen: false)
                      //             .totalofferNames,
                      //     'message': noteMessage,
                      //   });
                      //
                      //   try {
                      //     Navigator.pop(context);
                      //     Provider.of<SlmlmProvider>(context, listen: false)
                      //         .setAddOnItemQuantity(0);
                      //     addProductDialog(
                      //       context,
                      //       Provider.of<SlmlmProvider>(context, listen: false)
                      //           .quantity,
                      //     );
                      //     await dbHelper.addToCart(p1);
                      //   } catch (e) {
                      //     Navigator.pop(context);
                      //     addProductDialog(
                      //         context,
                      //         Provider.of<SlmlmProvider>(context, listen: false)
                      //             .quantity);
                      //     dbHelper.updateCourse(p1);
                      //   }
                      // } else {
                      //   print("you can'/t");
                      //   SnackBarService.showErrorMessage(
                      //       DemoLocalizations.of(context)
                      //           .title['subItemMorethanMainItem']);
                      // }
                    },
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
          ],
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                // image: AssetImage('images/foodBackground.png'),
                image: AssetImage('images/foodDetailsBackground.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 15,
                        right: 5,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Provider.of<SlmlmProvider>(context, listen: false)
                                .setAddOnItemQuantity(0);
                            Provider.of<SlmlmProvider>(context, listen: false)
                                .subItemsList = [];
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1000)),
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.clear,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            child: product.image == null
                                ? Image.asset("images/no-img.jpg")
                                : FadeInImage.assetNetwork(
                                    placeholder: "images/no-img.jpg",
                                    image: product.image,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        .32,
                                    fit: BoxFit.cover,
                                  ),
                            borderRadius: BorderRadius.circular(80),
                          ),
                        ),
                        right: MediaQuery.of(context).size.width * 0.3,
                        top: 145,
                        // top: MediaQuery.of(context).size.width * 0.3,
                      ),
                      Positioned(
                        top: 72,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                product.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  height: 1.1,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ' g 300',
                                    // product.description,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  Text(
                                    ' - cal ',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black45),
                                  ),
                                  Text(
                                    ' 190 ',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black45),
                                  ),
                                  Icon(Icons.local_fire_department,
                                      color: Colors.black45),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .05,
                            right: MediaQuery.of(context).size.width * .05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .025,
                            ),
                            Text(
                              DemoLocalizations.of(context)
                                  .title['description'],
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .005,
                            ),
                            Text(
                              product.description ?? '',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .015,
                            ),
                            SubOfferItem(
                              totalPrice: totalPrice,
                              quantity: quantity,
                              product: product,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .025,
                            ),
                            Text(
                              DemoLocalizations.of(context)
                                  .title['Choosetherighttype'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(h.blueColor),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .015,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(right: 10, left: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black12, width: 1),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.1),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return Container(
                                      height: 1,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.black12,
                                    );
                                  },
                                  itemCount: data.length,
                                  primary: false,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              width: 55,
                                              height: 55,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(h.mainColor),
                                                    width: 2),
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 5,
                                                  ),
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: data[index].image == null
                                                    ? Image.asset(
                                                        "images/no-img.jpg",
                                                        width: 45,
                                                        height: 45,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : FadeInImage.assetNetwork(
                                                        placeholder:
                                                            "images/Spinner.gif",
                                                        image: data[index]
                                                                    .image ==
                                                                null
                                                            ? ""
                                                            : data[index].image,
                                                        width: 45,
                                                        height: 45,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              data[index].name,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: AddOnItemsWidget(
                                              subItemTotalPrice:
                                                  subItemTotalPrice,
                                              subItemProduct: data[index],
                                              quantity: quantityOffer,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .015,
                            ),
                            Text(
                              DemoLocalizations.of(context).title['makenote'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(h.blueColor),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .015),
                            // make notes
                            Container(
                              width: MediaQuery.of(context).size.width * .9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                minLines: 1,
                                maxLines: 2,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    right: 15,
                                    left: 15,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  enabledBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.black12)),
                                  focusedBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.black12)),
                                  focusedErrorBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  errorBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  hintText: DemoLocalizations.of(context).title[
                                      'Wouldyouliketotellusanythingelse?'],
                                  hintStyle: TextStyle(
                                      color: Colors.black54, fontSize: 10),
                                  prefixIcon: Icon(
                                    Icons.message,
                                    color: Colors.black26,
                                  ),
                                  prefixIconConstraints: BoxConstraints(
                                      maxHeight: 25,
                                      minHeight: 20,
                                      maxWidth: 50,
                                      minWidth: 40),
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    noteMessage = value;
                                  });
                                },
                                // controller: message,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .03,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addProductNotes(BuildContext context, int count) {
    showDialog(
      // context: ctx,
      builder: (BuildContext ctx) => Dialog(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 150.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              border: Border.all(color: Colors.black12, width: 2.0),
              color: Colors.white),
          child: Container(
            width: MediaQuery.of(ctx).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              color: Colors.white,
            ),
            child: TextFormField(
              minLines: 1,
              maxLines: 2,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  right: 15,
                  left: 15,
                  top: 10,
                  bottom: 10,
                ),
                enabledBorder: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black12,
                  ),
                ),
                focusedBorder: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black12),
                ),
                focusedErrorBorder: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                errorBorder: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                hintText: DemoLocalizations.of(context)
                    .title['Wouldyouliketotellusanythingelse?'],
                hintStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 10,
                ),
                prefixIcon: Icon(
                  Icons.message,
                  color: Colors.black26,
                ),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 25,
                  minHeight: 20,
                  maxWidth: 50,
                  minWidth: 40,
                ),
              ),
              onFieldSubmitted: (String value) {
                setState(() {
                  noteMessage = value;
                });
              },
              onTap: () {},
              controller: message,
            ),
          ),
        ),
      ),
    );
  }

  addProductDialog(BuildContext context, int count) {
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
                          Text(
                            DemoLocalizations.of(context).title['qunt'] +
                                "$count",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
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

  Future<int> triggerFavourite(
      int productId, FavoriteModelLocal favoriteModel) async {
    int status = await getFavouriteStatus(productId);
    if (status == 0) {
      dbHelper.addToFavorite(favoriteModel);
      return 1;
    } else {
      dbHelper.deleteFavorite(productId);
      return 0;
    }
  }

  Future<int> getFavouriteStatus(int productId) async {
    bool found = await dbHelper.isProductFoundInFavouriteTable(productId);
    if (found == true) {
      return 1;
    } else {
      return 0;
    }
  }

  _makingPhoneCall() async {
    const url = 'tel:920007749';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  confirmCloseApp(BuildContext context) {
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Image.asset(
                            "images/icon/about.png",
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            DemoLocalizations.of(context)
                                .title['Doyouwanttoclosetheapplication?'],
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
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
                                border: Border.all(
                                    color: Colors.black38, width: 1.0),
                                color: Colors.white),
                            height: MediaQuery.of(context).size.height * .045,
                            width: MediaQuery.of(context).size.width * .32,
                            alignment: Alignment.center,
                            child: Text(
                              DemoLocalizations.of(context).title['cancell'],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
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
                            width: MediaQuery.of(context).size.width * .32,
                            alignment: Alignment.center,
                            child: Text(
                              DemoLocalizations.of(context).title['confirm'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ),
                          onTap: () async {
                            SystemNavigator.pop();
                            Navigator.pop(context);
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
