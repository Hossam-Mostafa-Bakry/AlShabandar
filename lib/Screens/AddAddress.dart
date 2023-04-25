import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/Model/Region.dart';
import 'package:mishwar/Screens/DelveryUser/MapsProvider.dart';
import 'package:mishwar/Screens/confirmedorderui/second_step_address.dart';
import 'package:mishwar/app/Services/AddressServices.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:mishwar/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'DelveryUser/customMap.dart';
import '../Model/RegionModel.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Screens/Addreses.dart';
import 'dart:async';

class AddAddress extends StatefulWidget {
  String type;

  AddAddress(String type) {
    this.type = type;
  }

  @override
  State<StatefulWidget> createState() {
    return _state(this.type);
  }
}

class _state extends State<AddAddress> {
  String type;

  _state(String type) {
    this.type = type;
  }

  TextEditingController searchzone = new TextEditingController();

  //// PickResult _pickedLocation;

  home h = new home();
  bool locationScreen = false;
  var key = "00966";
  var key2 = "00966";

  //homeaddress workaddress other
  List<String> addresstype = [];
  List<Region> RegionList = [];
  List<Region> RegionList0 = [];
  AddressServices addressServices = new AddressServices();

  loadData() async {
    RegionList0 = await addressServices.getRegions();
    // RegionList0 = await addressServices.GetRegions();
    setState(() {
      RegionList = RegionList0;
    });
  }

  String SelectedRegion;
  String SelectedRegionId = '';
  TextEditingController phone = new TextEditingController();
  TextEditingController search = new TextEditingController();
  TextEditingController phone2 = new TextEditingController();
  TextEditingController city = new TextEditingController();
  TextEditingController zone = new TextEditingController();
  TextEditingController flatNumber = new TextEditingController();
  TextEditingController floorLevel = new TextEditingController();

  TextEditingController street = new TextEditingController();
  TextEditingController location = new TextEditingController();
  TextEditingController mark = new TextEditingController();
  FocusNode zoneNode = new FocusNode();
  FocusNode phone2Node = new FocusNode();
  FocusNode streetNode = new FocusNode();
  FocusNode locationNode = new FocusNode();
  FocusNode phoneNode = new FocusNode();
  FocusNode markNode = new FocusNode();
  FocusNode flatNumberNode = new FocusNode();
  FocusNode floorLevelNode = new FocusNode();
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String latitude = '00.00000';
  String longitude = '00.00000';
  List<Placemark> newPlace;
  CameraPosition c;
  bool isError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    Provider.of<MapProvider>(context, listen: false).address = "";
    setState(() {
      // phone.text = home.phone.substring(3);
      // key = home.phone.substring(0, 3);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    location.clear();
  }

  @override
  Widget build(BuildContext context) {
    addresstype = [
      DemoLocalizations.of(context).title['homeaddress'],
      DemoLocalizations.of(context).title['workaddress'],
      DemoLocalizations.of(context).title['other']
    ];
    return Scaffold(
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
                          size: 25, color: Colors.black)
                      : Icon(Icons.arrow_forward_ios_rounded,
                          size: 25, color: Colors.black)),
              Expanded(
                child: Consumer<MapProvider>(
                  builder: (context, ch, _) => Text(
                    ch == null || ch.address.isEmpty
                        ? DemoLocalizations.of(context).title['addnewadrress']
                        : ch.address,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
        //endDrawer: MyDrawer(-1),
        body: RegionList0?.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .05,
                          right: MediaQuery.of(context).size.width * .05),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              SelectRegion(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .065,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: isError && SelectedRegion == null
                                        ? Colors.red
                                        : Color(h.borderColor),
                                    width: 1),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    SelectedRegion == null
                                        //ChooseRegion
                                        ? DemoLocalizations.of(context)
                                            .title['ChooseRegion']
                                        : SelectedRegion,
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                  Icon(Icons.keyboard_arrow_down_outlined,
                                      color: Colors.black45)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .9,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              focusNode: streetNode,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(markNode);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    right: 15, left: 15, top: 0, bottom: 0),
                                enabledBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Color(h.borderColor))),
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
                                hintText: DemoLocalizations.of(context)
                                    .title['street'],
                                errorStyle: TextStyle(fontSize: 0),
                                hintStyle: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              controller: street,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * .43,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  focusNode: floorLevelNode,
                                  onFieldSubmitted: (value) {
                                    // FocusScope.of(context)
                                    //     .requestFocus(floorLevelNode);
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        right: 15, left: 15, top: 0, bottom: 0),
                                    enabledBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Color(h.borderColor))),
                                    focusedBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Color(h.FocusBorderColor))),
                                    focusedErrorBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(h.ErorrBorderColor),
                                      ),
                                    ),
                                    errorBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Color(h.ErorrBorderColor))),
                                    hintText: DemoLocalizations.of(context)
                                        .title['floorlevel'],
                                    errorStyle: TextStyle(fontSize: 0),
                                    hintStyle: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  controller: floorLevel,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .43,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  focusNode: flatNumberNode,
                                  onFieldSubmitted: (value) {
                                    // FocusScope.of(context)
                                    //     .requestFocus(flatNumberNode);
                                  },
                                  // validator: (value) {
                                  //   if (value.isEmpty) {
                                  //     return '';
                                  //   }
                                  //   return null;
                                  // },
                                  //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        right: 15, left: 15, top: 0, bottom: 0),
                                    enabledBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Color(h.borderColor))),
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
                                    hintText: DemoLocalizations.of(context)
                                        .title['flatnumber'],
                                    errorStyle: TextStyle(fontSize: 0),
                                    hintStyle: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  controller: flatNumber,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .9,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              focusNode: markNode,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(phoneNode);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    right: 15, left: 15, top: 0, bottom: 0),
                                enabledBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Color(h.borderColor))),
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
                                hintText: DemoLocalizations.of(context)
                                    .title['landmark'],
                                errorStyle: TextStyle(fontSize: 0),
                                hintStyle: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              controller: mark,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          /* Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * .22,
                                  height: 47,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        width: 1,
                                        color: isError
                                            ? Color(h.ErorrBorderColor)
                                            : Color(h.borderColor)),
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          .01,
                                      right: MediaQuery.of(context).size.width *
                                          .01),
                                  child: Container(
                                    //width: MediaQuery.of(context).size.width*.22,
                                    alignment: Alignment.center,
                                    child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: CountryCodePicker(
                                        alignLeft: false,
                                        flagWidth: 35,
                                        padding: EdgeInsets.zero,
                                        onChanged: (v) {
                                          setState(() {
                                            key = v.toString();
                                          });
                                          print(key);
                                        },
                                        dialogTextStyle: TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                        hideMainText: false,
                                        showFlagMain: true,
                                        showFlag: true,
                                        initialSelection: '+966',
                                        hideSearch: false,
                                        textStyle: TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                        favorite: ["EG", "SA"],
                                        showCountryOnly: false,
                                        showOnlyCountryWhenClosed: false,
                                      ),
                                    ),
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width * .64,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  focusNode: phoneNode,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(phone2Node);
                                    print('${phone.text.substring(1)}');
                                    print('${key + phone.text.substring(1)}');
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                  //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        right: 15, left: 15, top: 0, bottom: 0),
                                    enabledBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Color(h.borderColor))),
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
                                    hintText: DemoLocalizations.of(context)
                                        .title['phone'],
                                    errorStyle: TextStyle(fontSize: 0),
                                    hintStyle: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  controller: phone,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * .22,
                                height: 47,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      width: 1,
                                      color: isError
                                          ? Color(h.ErorrBorderColor)
                                          : Color(h.borderColor)),
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * .01,
                                    right: MediaQuery.of(context).size.width *
                                        .01),
                                child: Container(
                                  //width: MediaQuery.of(context).size.width*.22,
                                  alignment: Alignment.center,
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: CountryCodePicker(
                                      alignLeft: false,
                                      flagWidth: 35,
                                      padding: EdgeInsets.zero,
                                      onChanged: (v) {
                                        setState(() {
                                          key2 = v.toString();
                                        });
                                        print(key2);
                                      },
                                      dialogTextStyle: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                      hideMainText: false,
                                      showFlagMain: true,
                                      showFlag: true,
                                      initialSelection: key2,
                                      hideSearch: false,
                                      textStyle: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                      favorite: ["EG", "SA"],
                                      showCountryOnly: false,
                                      showOnlyCountryWhenClosed: false,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .64,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  focusNode: phone2Node,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    print('${phone2.text.substring(1)}');
                                    print('${key + phone2.text.substring(1)}');
                                  },
                                  // validator: (value) {
                                  //   if (value.isEmpty) {
                                  //     return null;
                                  //   }
                                  //   return null;
                                  // },
                                  //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        right: 15, left: 15, top: 0, bottom: 0),
                                    enabledBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Color(h.borderColor))),
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
                                    hintText: DemoLocalizations.of(context)
                                        .title['Alternativephonenumber'],
                                    errorStyle: TextStyle(fontSize: 0),
                                    hintStyle: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  controller: phone2,
                                ),
                              ),
                            ],
                          ),*/
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Consumer<MapProvider>(
                                builder: (context, ch, _) => Container(
                                  width: MediaQuery.of(context).size.width * .64,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        color: isError
                                            ? Colors.red
                                            : Color(h.borderColor),
                                        width: 1),
                                    color: Colors.white,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                                    enabled: false,
                                    //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          right: 15,
                                          left: 15,
                                          top: 0,
                                          bottom: 0),
                                      disabledBorder: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.borderColor))),
                                      focusedBorder: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Color(h.FocusBorderColor))),
                                      focusedErrorBorder:
                                          new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Color(
                                                      h.ErorrBorderColor))),
                                      errorBorder: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Color(h.ErorrBorderColor))),
                                      hintText: ch == null
                                          ? DemoLocalizations.of(context)
                                                  .title['locationonmap'] +
                                              DemoLocalizations.of(context)
                                                  .title['addressName']
                                          : ch.address,
                                      errorStyle: TextStyle(fontSize: 0),
                                      hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    // controller: location,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => GoogleMapBody(
                                        trackProvider: false,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * .23,
                                  height:
                                      MediaQuery.of(context).size.height * .07,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        color: isError
                                            ? Colors.red
                                            : Color(h.borderColor),
                                        width: 1),
                                    color: Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                  child: ImageIcon(
                                    AssetImage("images/mapLocator.png"),
                                    size: 20,
                                    color: Color(h.mainColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              if (SelectedRegionId == '') {
                                Toast.show(
                                    DemoLocalizations.of(context)
                                        .title['regionrequired'],
                                    context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              } else if (Provider.of<MapProvider>(context,
                                          listen: false)
                                      .lat ==
                                  null) {
                                Toast.show(
                                    DemoLocalizations.of(context)
                                        .title['selectyourregion'],
                                    // "يرجي تحديد الموقع",
                                    context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              } else {
                                if (formKey.currentState.validate()) {
                                  // if (phone.text.substring(0, 1) == "0") {
                                  //   setState(() {
                                  //     phone.text = phone.text.substring(1);
                                  //   });
                                  //   print('${key + phone.text.substring(1)}');
                                  // }
                                  // if (phone2.text != "") {
                                  //   print(phone2.text);
                                  //   print(
                                  //       "ssssssssssssssssssssssssssssssssssssssssssss");
                                  //   if (phone2.text.substring(0, 1) == "0") {
                                  //     setState(() {
                                  //       phone2.text = phone2.text.substring(1);
                                  //     });
                                  //   }
                                  // }
                                  Map<String, dynamic> responce =
                                      await addressServices.addAddressService(

                                    user_id: prefs.getString("UserId"),
                                    region_id: SelectedRegionId,
                                    title: Provider.of<MapProvider>(context, listen: false).address,
                                    region: SelectedRegion,
                                    // address: street.text,
                                    mark: mark.text,
                                    lat: Provider.of<MapProvider>(context, listen: false).lat.toString(),
                                    lng: Provider.of<MapProvider>(context, listen: false).lng.toString(),
                                    flat: flatNumber.text,
                                    floor: floorLevel.text,
                                    // _pickedLocation.adrAddress.. .toString(),
                                    //prefs.getString("lat"),
                                    // _pickedLocation.latLng.longitude.toString(),
                                    // phone: "$key${phone.text}",
                                    // phone2: "$key2${phone2.text}",

                                  );
                                  if (responce["item1"] == 200) {
                                    setState(() {
                                      ParentPage.address = null;
                                    });
                                    if (type == "confirm") {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SecondStepAddress()),
                                      );
                                      Provider.of<MapProvider>(context, listen: false).address = "";
                                    } else {
                                      Navigator.pop(context);
                                      Future.delayed(Duration(seconds: 0),
                                          () async {
                                        await Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Adresses(),
                                          ),
                                        );
                                      });
                                      Provider.of<MapProvider>(context, listen: false).address = "";
                                    }
                                    Toast.show(
                                        //addaddressdone
                                        DemoLocalizations.of(context)
                                            .title['addaddressdone'],
                                        context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM);
                                    Provider.of<MapProvider>(context, listen: false).address = "";
                                  } else {
                                    Toast.show(
                                        "${responce["Message"]}", context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM);
                                  }
                                } else {
                                  setState(() {
                                    isError = true;
                                  });
                                }
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(h.blueColor),
                              ),
                              height: MediaQuery.of(context).size.height * .065,
                              width: MediaQuery.of(context).size.width * .9,
                              alignment: Alignment.center,
                              child: Text(
                                DemoLocalizations.of(context).title['confirm'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }

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
                                RegionList = [];
                              });
                              for (int i = 0; i < RegionList0.length; i++) {
                                setState(() {
                                  if (RegionList0[i].nameAr.contains(val)) {
                                    RegionList.add(RegionList0[i]);
                                  }
                                });
                                // FocusScope.of(context).requestFocus(FocusNode());
                                setState(() {});
                              }
                              print(RegionList.length);
                              print(
                                  "1111111111111111111111111111111111111111111111111111");
                            } else {
                              setState(() {
                                RegionList = RegionList0;
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
                                  borderSide:
                                      BorderSide(color: Colors.black38)),
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
                                  color: Colors.black45)),
                          controller: searchzone,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: RegionList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              setState(() {
                                SelectedRegion = RegionList[index].nameAr;
                                SelectedRegionId =
                                    RegionList[index].regionId.toString();
                              });

                              Navigator.pop(context);
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        .005,
                                    top: MediaQuery.of(context).size.height *
                                        .005),
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        .005,
                                    top: MediaQuery.of(context).size.height *
                                        .005),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Color(h.blueColor)),
                                alignment: Alignment.center,
                                child: Text(
                                  RegionList[index].nameAr,
                                  style: TextStyle(color: Colors.white),
                                )),
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
