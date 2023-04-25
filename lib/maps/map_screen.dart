// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// // import 'package:amlak/core/shared/app_bar_shared.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:map_launcher/map_launcher.dart';

// import 'maps_sheet.dart';

// class GoogleMapBody1 extends StatefulWidget {
//   GoogleMapBody1({
//     Key key,
//   }) : super(key: key);

//   @override
//   _GoogleMapBody1State createState() => _GoogleMapBody1State();
// }

// class _GoogleMapBody1State extends State<GoogleMapBody1> {
//   BitmapDescriptor driverLocationIcon;
//   BitmapDescriptor userLocationIcon;
//   BitmapDescriptor customIcon;
//   Position initialPosition;

//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   Future<Position> _determinePosition() async {
//     try {
//       await Geolocator.getCurrentPosition().then((value) {
//         initialPosition = value;
//       });
//       print(initialPosition);
//     } catch (e) {
//       // default position on map at Kuwait, Hawally.
//       initialPosition = Position(latitude: 29.3378, longitude: 48.0235);
//     }
//     return initialPosition;
//   }

//   Position position;
//   bool init = true;
//   @override
//   void didChangeDependencies() async {
//     if (init) {
//       await Future.delayed(Duration(microseconds: 0)).then((value) async {
//         await _determinePosition().then((value) async {
//           //   createOrderCubit.geoLocation = '${value.latitude},${value.longitude}';
//         });
//       });
//       setState(() {
//         init = false;
//       });
//     }
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       // appBar: appBarUi('اختر الموقع'),
//       body: init == true
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 GoogleMap(
//                   mapToolbarEnabled: true,
//                   zoomControlsEnabled: true,
//                   scrollGesturesEnabled: true,
//                   myLocationButtonEnabled: true,
//                   myLocationEnabled: true,
//                   onCameraMove: ((_position) {
//                     // createOrderCubit.geoLocation =
//                     //     '${_position.target.latitude},${_position.target.longitude}';
//                   }),
//                   gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
//                     Factory<OneSequenceGestureRecognizer>(
//                       () => EagerGestureRecognizer(),
//                     ),
//                   },
//                   initialCameraPosition: CameraPosition(
//                     zoom: 14,
//                     target: LatLng(
//                         initialPosition.latitude, initialPosition.longitude),
//                   ),
//                 ),
//                 pin(),
//                 Platform.isIOS
//                     ? InkWell(
//                         onTap: () {
//                           MapsSheet.show(
//                             context: context,
//                             onMapTap: (map) {
//                               map.showMarker(
//                                 coords: Coords(initialPosition.latitude,
//                                     initialPosition.longitude),
//                                 title: "  ",
//                                 // zoom: zoom,
//                               );
//                             },
//                           );
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 8.0, top: 10),
//                           child: Align(
//                             alignment: Alignment.topLeft,
//                             child: InkWell(
//                               child: Icon(
//                                 Icons.location_on,
//                                 size: 30,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     : Container()
//               ],
//             ),
//     );
//   }

//   Widget pin() {
//     return IgnorePointer(
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Icon(Icons.place, size: 56),
//             Container(
//                 width: 60,
//                 height: 60,
//                 child: Image.asset('assets/marker.png')),
//             Container(
//               decoration: ShapeDecoration(
//                 shadows: [
//                   BoxShadow(
//                     blurRadius: 4,
//                     color: Colors.black38,
//                   ),
//                 ],
//                 shape: CircleBorder(
//                   side: BorderSide(
//                     width: 4,
//                     color: Colors.transparent,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 56),
//           ],
//         ),
//       ),
//     );
//   }
// }
