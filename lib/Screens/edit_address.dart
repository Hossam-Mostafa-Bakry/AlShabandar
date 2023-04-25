import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mishwar/Model/Region.dart';
import 'package:mishwar/Screens/DelveryUser/MapsProvider.dart';
import 'package:mishwar/Screens/confirmedorderui/second_step_address.dart';
import 'package:mishwar/Services/snackbar_service.dart';
import 'package:mishwar/app/Services/AddressServices.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:mishwar/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/AddressModel.dart';
import 'DelveryUser/customMap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditAddress extends StatefulWidget {
  AddressModel addressModel;

  EditAddress(this.addressModel);

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  TextEditingController searchzone = TextEditingController();

  //// PickResult _pickedLocation;
  home h = home();
  bool locationScreen = false;
  var key = "00966";
  var key2 = "00966";

  //homeaddress workaddress other
  List<String> addresstype = [];
  List<Region> RegionList = [];
  List<Region> RegionList0 = [];
  AddressServices addressServices = AddressServices();

  loadData() async {
    RegionList0 = await addressServices.getRegions();
    // RegionList0 = await addressServices.GetRegions();
    setState(() {
      RegionList = RegionList0;
    });
  }

  String SelectedRegion;
  String SelectedRegionId = '';
  TextEditingController phone = TextEditingController();
  TextEditingController search = TextEditingController();
  TextEditingController phone2 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zone = TextEditingController();
  TextEditingController flatNumber = TextEditingController();
  TextEditingController floorLevel = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController mark = TextEditingController();

  FocusNode zoneNode = FocusNode();
  FocusNode phone2Node = FocusNode();
  FocusNode streetNode = FocusNode();
  FocusNode locationNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode markNode = FocusNode();
  FocusNode flatNumberNode = FocusNode();
  FocusNode floorLevelNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String latitude = '00.00000';
  String longitude = '00.00000';

  List<Placemark> Place;
  CameraPosition c;

  bool isError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    Provider.of<MapProvider>(context, listen: false).address = "";
    setState(() {});
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
              child: Text(
                DemoLocalizations.of(context).title['edit_address'],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  SelectedRegion != null
                                  ? SelectedRegion
                                  : widget.addressModel.region != null
                                      ? widget.addressModel.region
                                      : "",
                                  style: TextStyle(color: Colors.black87),
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
                        // street text field
                        Container(
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            initialValue: widget.addressModel.title ??
                                DemoLocalizations.of(context).title['street'],
                            focusNode: streetNode,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(floorLevelNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  right: 15, left: 15, top: 0, bottom: 0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Color(h.borderColor))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(h.FocusBorderColor))),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(h.ErorrBorderColor))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(h.ErorrBorderColor))),
                              hintText:
                                  DemoLocalizations.of(context).title['street'],
                              errorStyle: TextStyle(fontSize: 0),
                              hintStyle: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // floor text field
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
                                initialValue: widget.addressModel.floor ??
                                    DemoLocalizations.of(context)
                                        .title['floorlevel'],
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(flatNumberNode);
                                },
                                onChanged: (value) {
                                  widget.addressModel.floor = value;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      right: 15, left: 15, top: 0, bottom: 0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.borderColor))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.FocusBorderColor))),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color(h.ErorrBorderColor),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.ErorrBorderColor))),
                                  hintText: widget.addressModel.floor ??
                                      DemoLocalizations.of(context)
                                          .title['floorlevel'],
                                  errorStyle: TextStyle(fontSize: 0),
                                  hintStyle: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            // flat text field
                            Container(
                              width: MediaQuery.of(context).size.width * .43,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                initialValue: widget.addressModel.flat ??
                                    DemoLocalizations.of(context)
                                        .title['flatnumber'],
                                focusNode: flatNumberNode,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(markNode);
                                },
                                onChanged: (value) {
                                  widget.addressModel.flat = value;
                                  debugPrint(
                                      "flat: ${widget.addressModel.flat}");
                                },
                                // validator: (value) {
                                //   if (value.isEmpty) {
                                //     return '';
                                //   }
                                //   return null;
                                // },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      right: 15, left: 15, top: 0, bottom: 0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.borderColor))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.FocusBorderColor))),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.ErorrBorderColor))),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.ErorrBorderColor))),
                                  hintText: DemoLocalizations.of(context)
                                      .title['flatnumber'],
                                  errorStyle: TextStyle(fontSize: 0),
                                  hintStyle: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // land mark text field
                        Container(
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            initialValue: widget.addressModel.landMark ??
                                DemoLocalizations.of(context).title['landmark'],
                            focusNode: markNode,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).requestFocus(phoneNode);
                            },
                            onChanged: (value) {
                              widget.addressModel.landMark = value;
                              debugPrint(
                                  "mark: ${widget.addressModel.landMark}");
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  right: 15, left: 15, top: 0, bottom: 0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Color(h.borderColor))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(h.FocusBorderColor))),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(h.ErorrBorderColor))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(h.ErorrBorderColor))),
                              hintText: DemoLocalizations.of(context)
                                  .title['landmark'],
                              errorStyle: TextStyle(fontSize: 0),
                              hintStyle: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // map
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<MapProvider>(
                              builder: (context, ch, _) => Container(
                                width: MediaQuery.of(context).size.width * .64,
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
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    value = ch.address;
                                    widget.addressModel.address = ch.address;
                                  },
                                  enabled: false,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        right: 15, left: 15, top: 0, bottom: 0),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Color(h.borderColor))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Color(h.FocusBorderColor))),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Color(h.ErorrBorderColor))),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Color(h.ErorrBorderColor))),
                                    hintText: ch == null || ch.address.isEmpty
                                        ? widget.addressModel.title
                                        : ch.address,
                                    errorStyle: TextStyle(fontSize: 0),
                                    hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
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
                                width: MediaQuery.of(context).size.width * .23,
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
                          height: 40,
                        ),
                        Consumer<MapProvider>(
                          builder: (context, ch, child) => InkWell(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              // if (formKey.currentState.validate()) {
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
                              dynamic responce =
                                  await addressServices.updateAddress(
                                address_id: widget.addressModel.id,
                                region_id: SelectedRegion == null
                                    ? widget.addressModel.regionId
                                    : SelectedRegionId,
                                region: SelectedRegion == null
                                    ? widget.addressModel.region
                                    : SelectedRegion,
                                title: ch == null || ch.address.isEmpty
                                    ? widget.addressModel.title
                                    : Provider.of<MapProvider>(context,
                                            listen: false)
                                        .address,
                                mark: widget.addressModel.landMark,
                                lat: widget.addressModel.lat,
                                lng: widget.addressModel.lng,
                                flat: widget.addressModel.flat,
                                floor: widget.addressModel.floor,
                              );
                              EasyLoading.show();
                              if (responce["item1"] == 200) {
                                setState(() {
                                  ParentPage.address = null;
                                });
                                debugPrint(
                                    "responss :  ${responce.toString()}");
                                EasyLoading.dismiss();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SecondStepAddress(),
                                    ),
                                );
                                // if (type == "confirm") {
                                //   Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             SecondStepAddress()),
                                //   );
                                //   Provider.of<MapProvider>(context).address = "";
                                // } else {
                                //   Navigator.pop(context);
                                //   Future.delayed(Duration(seconds: 0),
                                //           () async {
                                //         await Navigator.pushReplacement(
                                //           context,
                                //           MaterialPageRoute(
                                //             builder: (context) => Adresses(),
                                //           ),
                                //         );
                                //       });
                                //   Provider.of<MapProvider>(context).address = "";
                                // }
                                SnackBarService.showSuccessMessage(
                                  DemoLocalizations.of(context)
                                      .title['changes_saved_successfully'],
                                );
                                Provider.of<MapProvider>(context, listen: false)
                                    .address = "";
                              } else {
                                EasyLoading.dismiss();
                                SnackBarService.showErrorMessage(
                                  DemoLocalizations.of(context)
                                      .title["changes_wasn't_saved"],
                                );
                              }

                              // if (SelectedRegionId == '') {
                              //   // Toast.show(DemoLocalizations.of(context).title['regionrequired'],
                              //   //     context,
                              //   //     duration: Toast.LENGTH_LONG,
                              //   //     gravity: Toast.BOTTOM);
                              // } else if (Provider.of<MapProvider>(context, listen: false).lat == null) {
                              //   Toast.show(DemoLocalizations.of(context).title['selectyourregion'],
                              //       // "يرجي تحديد الموقع",
                              //       context,
                              //       duration: Toast.LENGTH_LONG,
                              //       gravity: Toast.BOTTOM);
                              // } else {
                              //   if (formKey.currentState.validate()) {
                              //     // if (phone.text.substring(0, 1) == "0") {
                              //     //   setState(() {
                              //     //     phone.text = phone.text.substring(1);
                              //     //   });
                              //     //   print('${key + phone.text.substring(1)}');
                              //     // }
                              //     // if (phone2.text != "") {
                              //     //   print(phone2.text);
                              //     //   print(
                              //     //       "ssssssssssssssssssssssssssssssssssssssssssss");
                              //     //   if (phone2.text.substring(0, 1) == "0") {
                              //     //     setState(() {
                              //     //       phone2.text = phone2.text.substring(1);
                              //     //     });
                              //     //   }
                              //     // }
                              //     Map<String, dynamic> responce =
                              //         await addressServices.updateAddress(
                              //       user_id: prefs.getString("UserId"),
                              //       title: !SelectedRegion.isEmpty ? SelectedRegion : widget.addressModel.title,
                              //       // title: Provider.of<MapProvider>(context, listen: false).address,
                              //       address: widget.addressModel.address,
                              //       // address: street.text,
                              //       mark: widget.addressModel.landMark,
                              //       lat: widget.addressModel.lat,
                              //       lng: widget.addressModel.lng,
                              //       flat: widget.addressModel.flat,
                              //       floor: widget.addressModel.floor,
                              //       // _pickedLocation.adrAddress.. .toString(),
                              //       //prefs.getString("lat"),
                              //       //  _pickedLocation.latLng.longitude.toString(),
                              //       // phone: "$key${phone.text}",
                              //       // phone2: "$key2${phone2.text}",
                              //       region_id: SelectedRegionId,
                              //     );
                              //     if (responce["statusCode"] == 200) {
                              //       setState(() {
                              //         ParentPage.address = null;
                              //       });
                              //       debugPrint(responce.toString());
                              //       // if (type == "confirm") {
                              //       //   Navigator.pushReplacement(
                              //       //     context,
                              //       //     MaterialPageRoute(
                              //       //         builder: (context) =>
                              //       //             SecondStepAddress()),
                              //       //   );
                              //       //   Provider.of<MapProvider>(context).address = "";
                              //       // } else {
                              //       //   Navigator.pop(context);
                              //       //   Future.delayed(Duration(seconds: 0),
                              //       //           () async {
                              //       //         await Navigator.pushReplacement(
                              //       //           context,
                              //       //           MaterialPageRoute(
                              //       //             builder: (context) => Adresses(),
                              //       //           ),
                              //       //         );
                              //       //       });
                              //       //   Provider.of<MapProvider>(context).address = "";
                              //       // }
                              //       Toast.show(
                              //           //addaddressdone
                              //           DemoLocalizations.of(context)
                              //               .title['addaddressdone'],
                              //           context,
                              //           duration: Toast.LENGTH_SHORT,
                              //           gravity: Toast.BOTTOM);
                              //       Provider.of<MapProvider>(context).address =
                              //           "";
                              //     } else {
                              //       Toast.show(
                              //           "${responce["Message"]}", context,
                              //           duration: Toast.LENGTH_SHORT,
                              //           gravity: Toast.BOTTOM);
                              //     }
                              //   } else {
                              //     setState(() {
                              //       isError = true;
                              //     });
                              //   }
                              // }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green,
                              ),
                              height: MediaQuery.of(context).size.height * .06,
                              width: MediaQuery.of(context).size.width * .9,
                              alignment: Alignment.center,
                              child: Text(
                                DemoLocalizations.of(context)
                                    .title['save_changes'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            Map<String, dynamic> response =
                                await AddressServices().deleteAddressService(
                                    widget.addressModel.id);

                            if (response["item1"] == 200) {
                              SnackBarService.showSuccessMessage(
                                  "${response["item2"]}");
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SecondStepAddress(),
                                  ));
                            } else {
                              SnackBarService.showErrorMessage(
                                DemoLocalizations.of(context)
                                    .title["can't_delete_address"],
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red.shade600,
                            ),
                            height: MediaQuery.of(context).size.height * .06,
                            width: MediaQuery.of(context).size.width * .9,
                            alignment: Alignment.center,
                            child: Text(
                              DemoLocalizations.of(context)
                                  .title['delete_address'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
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
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.black38)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(h.FocusBorderColor))),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(h.ErorrBorderColor))),
                              errorBorder: OutlineInputBorder(
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
                                widget.addressModel.region = SelectedRegion;
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
