import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mishwar/app/Services/MapServices.dart';

class GoogleMapCustomize extends StatefulWidget {
  final double driverLat, driverLong, clientLat, clientLng;

  GoogleMapCustomize({
    Key key,
    this.driverLat,
    this.driverLong,
    this.clientLat,
    this.clientLng,
  }) : super(key: key);

  @override
  State<GoogleMapCustomize> createState() => GoogleMapCustomizeState();
}

class GoogleMapCustomizeState extends State<GoogleMapCustomize> {
  Completer<GoogleMapController> _controller = Completer();

  Set<Polyline> _polylines = Set<Polyline>();

  // List<LatLng> _polylineCoordinates = [];
  // List<LatLng> _polygonLatLngs = <LatLng>[];
  // PolylinePoints _polylinePoints;
  Marker _clientMarker;
  Marker _driverMarker;
  Set<Marker> _marker = Set<Marker>();
  CameraPosition _clientCamera;
  CameraPosition _driverCamera;
  BitmapDescriptor driverIcon;
  BitmapDescriptor destinationIcon;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int _polylineIdCounter = 1;

  Future<Uint8List> _getBytesFromAsset(
    String path,
    int width,
    int height,
  ) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  setCustomMapPin() async {
    final Uint8List circularIcon =
        await _getBytesFromAsset('images/circlur.png', 300, 300);
    final Uint8List carIcon =
        await _getBytesFromAsset('images/car.png', 80, 80);
    destinationIcon = BitmapDescriptor.fromBytes(circularIcon);
    driverIcon = BitmapDescriptor.fromBytes(carIcon);
    print("get Map Image");
  }

  void addMarker() async {

    await setCustomMapPin();

    _marker.add(
      Marker(
        markerId: MarkerId('_clientMarker'),
        infoWindow: InfoWindow(title: 'Your Adrress'),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(widget.clientLat, widget.clientLng),
      ),
    );
    _marker.add(
      Marker(
        markerId: MarkerId('_driverMarker'),
        infoWindow: InfoWindow(title: 'Driver'),
        icon: driverIcon,
        position: LatLng(widget.driverLat, widget.driverLong),
      ),
    );
    setState(() {

    });
  }

  void setSourceAndDestinationMarkerIcons() async {
    driverIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        devicePixelRatio: 2.0,
      ),
      'images/car.png',
    );
  }

  bool init = true;

  @override
  void initState() {
    // TODO: implement initState
    addMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // key: scaffoldKey,
      body: GoogleMap(
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.334353976081296, -122.06636969000101),
          zoom: 15.5,
          // bearing: 80,
          // tilt: 30,
        ),
        polylines: _polylines,
        markers: _marker,
        onMapCreated: (GoogleMapController controller) async {
          _controller.complete(controller);

          var directions = await MapServises().getDirections(
            driverOriginlat: widget.driverLat.toString(),
            driverOriginlng: widget.driverLong.toString(),
            clientDestinationlat: widget.clientLat.toString(),
            clientDestinationlng: widget.clientLng.toString(),
          );

          setState(() {
            _goToPlace(
              directions['start_location']['lat'],
              directions['start_location']['lng'],
            );
            _setPolyline(directions['polyline_decoded']);
          });
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     MapServises().getDirections(
      //       driverOriginlat: widget.driverLat.toString(),
      //       driverOriginlng: widget.driverLong.toString(),
      //       clientDestinationlat: widget.clientLat.toString(),
      //       clientDestinationlng: widget.clientLng.toString(),
      //     );
      //   },
      // ),
    );
  }

  Future<void> _goToPlace(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 15.5,
        ),
      ),
    );
  }

  void _setPolyline(List<PointLatLng> points) {
    String polylineIdVal = 'polyline$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 3,
        color: Colors.red,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }
}

/*
_driverCamera = CameraPosition(
target: LatLng(widget.driverLat, widget.driverLong),
zoom: 15.5,
// bearing: 80,
// tilt: 30,
);

_clientCamera = CameraPosition(
// bearing: 80,
target: LatLng(widget.clientLat, widget.clientLng),
// tilt: 30,
zoom: 15.5,
);*/
