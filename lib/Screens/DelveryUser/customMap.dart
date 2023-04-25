import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mishwar/maps/maps_sheet.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'MapsProvider.dart';

class GoogleMapBody extends StatefulWidget {
  final bool trackProvider, removeMarker;
  final double driverLat, driverLong, lat, lng;

  final home h = home();
  GoogleMapBody(
      {Key key,
      @required this.trackProvider,
      this.driverLat,
      this.removeMarker,
      this.driverLong,
      this.lat,
      this.lng,
      })
      : super(key: key);

  @override
  _GoogleMapBodyState createState() => _GoogleMapBodyState();
}

class _GoogleMapBodyState extends State<GoogleMapBody> {

  Set<Marker> _markers = {};
  List<Placemark> placemarks = [];
  BitmapDescriptor driverLocationIcon;
  BitmapDescriptor userLocationIcon;
  Marker _addressMarker;
  Marker _driverAddressMarker;
  BitmapDescriptor customIcon;
  Position initialPosition;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
    userLocationIcon = BitmapDescriptor.fromBytes(circularIcon);
    driverLocationIcon = BitmapDescriptor.fromBytes(carIcon);
    print("get Map Image");
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    var data = await rootBundle.load(path);
    var codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    var fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Future addMareker(LatLng position) async {
    await setCustomMapPin();
    _addressMarker = Marker(
      markerId: MarkerId('address2'),
      position: LatLng(position.latitude, position.longitude),
      infoWindow: InfoWindow(title: "myLocation", onTap: () {}),
      icon: userLocationIcon,
    );

    _driverAddressMarker = Marker(
      markerId: MarkerId('addresss'),
      position: LatLng(widget.driverLat, widget.driverLong),
      infoWindow: InfoWindow(title: "provider's Location", onTap: () {}),
      icon: driverLocationIcon,
    );

    setState(() {
      _markers.add(_addressMarker);
      _markers.add(_driverAddressMarker);
    });
  }

  Future<Position> _determinePosition() async {

    try {
      await Geolocator.getCurrentPosition().then((value) {
        _determineAddress(value.latitude, value.longitude);
        initialPosition = value;
      });
      print('initial postion => $initialPosition');
    } catch (e) {
      // default position on map at Kuwait, Hawally.
      initialPosition = Position(latitude: 29.3378, longitude: 48.0235);
      print('error ya hoss');
    }
    return initialPosition;
  }

  Future<String> _determineAddress(double lat, double lng) async {
    try {
      placemarks = await placemarkFromCoordinates(lat, lng);

      Provider.of<MapProvider>(context, listen: false).selectAddress(
          addressParm: placemarks[0].street, latParm: lat, lngParm: lng);
      print("place marker: ${placemarks[0].street}");
      print("place body: ${placemarks.toString()}");
    } catch (e) {
      // default position on map at Kuwait, Hawally.
      Provider.of<MapProvider>(context, listen: false)
          .selectAddress(addressParm: '', latParm: 29.3378, lngParm: 48.0235);
    }
    return placemarks[0].street;
  }

  bool init = true;
  @override
  void didChangeDependencies() async {
    if (init) {

        await Future.delayed(Duration(microseconds: 0)).then((value) async {
          await _determinePosition().then((value) async {
            if (widget.trackProvider == true) {
              addMareker(LatLng(value.latitude, value.longitude));
            }
          });
        });

      setState(() {
        init = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(widget.h.mainColor),
        elevation: 0,
        toolbarHeight: 40,
        title: Consumer<MapProvider>(
          builder: (context, ch, child) => Text(
            ch.address,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        centerTitle: true,
      ),
      body: init == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMap(
                  mapToolbarEnabled: true,
                  zoomControlsEnabled: true,
                  scrollGesturesEnabled: true,
                  myLocationButtonEnabled:
                      widget.removeMarker == false ? false : true,
                  myLocationEnabled: true,
                  onCameraMove: !widget.trackProvider
                      ? ((_position) {
                          _determineAddress(_position.target.latitude,
                              _position.target.longitude);
                        })
                      : (_) {},
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  },
                  markers: _markers,
                  initialCameraPosition: CameraPosition(
                    zoom: widget.trackProvider ? 10 : 14,
                    target:widget.lat!=null?LatLng(
                       widget.lat,widget.lng) :LatLng(
                        initialPosition.latitude, initialPosition.longitude),
                  ),
                ),
                Visibility(visible: !widget.trackProvider, child: pin()),
                Platform.isIOS && widget.trackProvider
                    ? InkWell(
                        onTap: () {
                          MapsSheet.show(
                            context: context,
                            onMapTap: (map) {
                              map.showMarker(
                                coords: Coords(initialPosition.latitude,
                                    initialPosition.longitude),
                                title: "  ",
                                // zoom: zoom,
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              child: Icon(
                                Icons.location_on,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget pin() {
    return widget.removeMarker == false
        ? Container()
        : IgnorePointer(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Icon(Icons.place, size: 56),
                  Container(
                      width: 60,
                      height: 60,
                      child: Image.asset('images/marker.png')),
                  Container(
                    decoration: ShapeDecoration(
                      shadows: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black38,
                        ),
                      ],
                      shape: CircleBorder(
                        side: BorderSide(
                          width: 4,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 56),
                ],
              ),
            ),
          );
  }
}
