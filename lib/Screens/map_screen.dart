import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
const LatLng DEST_LOCATION = LatLng(42.744421, -71.1698939);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 20;
const double PIN_INVISIBLE_POSITION = -220;

class MapCustomPage extends StatefulWidget {
  @override
  _MapCustomPageState createState() => _MapCustomPageState();
}

class _MapCustomPageState extends State<MapCustomPage> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  Set<Marker> _marker = Set<Marker>();

  LatLng clientLocation;
  LatLng driverLocation;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    polylinePoints = PolylinePoints();

    // set up initial locations
    this.setInitialLocation();


    // set up the marker icons
    setClientAndDriverMarkerIcons();
  }

  void setClientAndDriverMarkerIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.0),
      'images/car.png',
    );
    destinationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.0),
      'images/marker.png',
    );
  }

  void setInitialLocation() {
    driverLocation = LatLng(
      SOURCE_LOCATION.latitude,
      SOURCE_LOCATION.longitude,
    );
    clientLocation = LatLng(
      DEST_LOCATION.latitude,
      DEST_LOCATION.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPostion = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              myLocationEnabled: true,
              compassEnabled: false,
              tiltGesturesEnabled: false,
              polylines: _polylines,
              markers: _marker,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPostion,
              onMapCreated: (GoogleMapController controller) {

                _controller.complete(controller);
                showPinOnMap();
                setPolylines();

              },
            ),
          ),
        ],
      ),
    );
  }

  void showPinOnMap() {
    setState(() {
      _marker.add(
        Marker(
          markerId: MarkerId('ClientPin'),
          position: clientLocation,
          icon: destinationIcon,
        ),
      );

      _marker.add(
        Marker(
          markerId: MarkerId('DriverPin'),
          position: driverLocation,
          icon: sourceIcon,
        ),
      );
    });
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyBHG1sJAP3tp8iIsHNd_McetWdmn14HDWI",
        PointLatLng(
            driverLocation.latitude,
            driverLocation.longitude
        ),
        PointLatLng(
            clientLocation.latitude,
            clientLocation.longitude
        )
    );

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(
            Polyline(
                width: 10,
                polylineId: PolylineId('polyLine'),
                color: Color(0xFF08A5CB),
                points: polylineCoordinates
            )
        );
      });
    }
  }
}
