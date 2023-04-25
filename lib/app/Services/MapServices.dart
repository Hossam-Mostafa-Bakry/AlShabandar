import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;

class MapServises {
  String key = 'AIzaSyBHG1sJAP3tp8iIsHNd_McetWdmn14HDWI';

  Future<Map<String, dynamic>> getDirections({
    @required String driverOriginlat,
    @required String driverOriginlng,
    @required String clientDestinationlat,
    @required String clientDestinationlng,
  }) async {
    var url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$driverOriginlat,$driverOriginlng&destination=$clientDestinationlat,$clientDestinationlng&key=$key';
    final response = await http.get(Uri.parse(url));

    print('map response => $response');
    var json = jsonDecode(response.body);

    var results = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded': PolylinePoints()
          .decodePolyline(json['routes'][0]['overview_polyline']['points']),
    };
    print(results);

    return results;
  }
}
