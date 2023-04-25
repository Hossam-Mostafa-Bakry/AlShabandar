import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mishwar/Model/BranchModel.dart';
import 'package:mishwar/main.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'DelveryUser/customMap.dart';
import 'map_customize.dart';

class BrachDetail extends StatefulWidget {
  BranchModelDetail branchModelDetail;

  BrachDetail(BranchModelDetail branchModelDetail) {
    this.branchModelDetail = branchModelDetail;
  }

  @override
  State<StatefulWidget> createState() {
    return _state(this.branchModelDetail);
  }
}

class _state extends State<BrachDetail> {
  BranchModelDetail branchModelDetail;

  _state(BranchModelDetail branchModelDetail) {
    this.branchModelDetail = branchModelDetail;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  home h = new home();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(branchModelDetail.lat);
    print(branchModelDetail.long);
    print(branchModelDetail.address.toString());
    // print(branchModelDetail.phone);
    // print(branchModelDetail.email);
    // print(branchModelDetail.taxNumber);
    // print(branchModelDetail.workingTime);
    print("0000000000000000000000000000000000000000000000000000000");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Color(0xffD4252F),
          title: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: DemoLocalizations.of(context).locale == Locale("en")
                      ? Icon(Icons.arrow_back_ios_rounded,
                          size: 25, color: Colors.white)
                      : Icon(Icons.arrow_forward_ios_rounded,
                          size: 25, color: Colors.white)),
              Expanded(
                child: Text(
                  branchModelDetail.name,
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
        //endDrawer: MyDrawer(-1),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .05,
                right: MediaQuery.of(context).size.width * .05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: FadeInImage.assetNetwork(
                    placeholder: "images/branch.png",
                    image: branchModelDetail.image == null
                        ? ""
                        : 'http://195.181.247.217/mishwar/branch/${branchModelDetail.image.substring(35)}',
                    height: MediaQuery.of(context).size.height * .25,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Text(
                  branchModelDetail.name,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                // address return null
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 17,
                      color: Colors.black45,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * .75,
                        child: Text(
                          branchModelDetail.address == null
                              ? ""
                              : branchModelDetail.address.toString(),
                          maxLines: 1,
                          style: TextStyle(color: Colors.black54, fontSize: 11),
                        ))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 17,
                      color: Colors.black45,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                        // width: MediaQuery.of(context).size.width*.7,
                        child: Text(
                      branchModelDetail.phone == null
                          ? ""
                          : branchModelDetail.phone,
                      textDirection: TextDirection.ltr,
                      maxLines: 1,
                      style: TextStyle(color: Colors.black54, fontSize: 11),
                    ))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 17,
                      color: Colors.black45,
                    ),
                    SizedBox(width: 5),
                    Container(
                        width: MediaQuery.of(context).size.width * .7,
                        //timesofwork
                        child: Text(
                          DemoLocalizations.of(context).title['timesofwork'],
                          maxLines: 1,
                          style: TextStyle(color: Colors.black54, fontSize: 11),
                        ))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .005,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 17,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Container(
                        width: MediaQuery.of(context).size.width * .7,
                        child: Text(
                          branchModelDetail.workingTime == null
                              ? ''
                              : branchModelDetail.workingTime.toString(),
                          maxLines: 1,
                          style: TextStyle(color: Colors.black54, fontSize: 11),
                        ))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .015,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: 1,
                  color: Colors.black12,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .015,
                ),
                branchModelDetail.lat != null
                    ? Column(
                        children: [
                          //Branchlocationonthemap

                          Container(
                            alignment: DemoLocalizations.of(context).locale ==
                                    Locale("en")
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Text(
                              DemoLocalizations.of(context)
                                  .title['Branchlocationonthemap'],
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .015,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            height: 350,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  zoom: 14,
                                  target: LatLng(
                                    double.parse(branchModelDetail.lat),
                                    double.parse(branchModelDetail.long),
                                  ),
                                ),
                                markers: {
                                  Marker(
                                    markerId: MarkerId('_driverMarker'),
                                    infoWindow: InfoWindow(title: 'Mishwar Branch'),
                                    icon: BitmapDescriptor.defaultMarker,
                                    position: LatLng(
                                      double.parse(branchModelDetail.lat),
                                      double.parse(branchModelDetail.long),
                                    ),
                                  ),
                                },
                              ),
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.symmetric(horizontal: 10),
                          //   width: double.infinity,
                          //   height: 350,
                          //   child: GoogleMapBody(
                          //     trackProvider: false,
                          //     removeMarker: false,
                          //     lat: double.parse(widget.branchModelDetail.lat),
                          //     lng: double.parse(widget.branchModelDetail.long),
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.symmetric(horizontal: 10),
                          //   width: double.infinity,
                          //   height: 350,
                          //   child: GoogleMapCustomize(
                          //     driverLat: double.parse(branchModelDetail.lat),
                          //     driverLong: double.parse(branchModelDetail.long),
                          //   ),
                          // ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
