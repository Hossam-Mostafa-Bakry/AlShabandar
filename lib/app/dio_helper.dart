import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mishwar/Model/direction_model.dart';

import 'AppConfig.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://www.mishwar.elmasren.com',
        receiveDataWhenStatusError: true,
       /* headers: {
          "Content-Type": "application/json",
          "X-Auth-Token": "dfbed9f22f0f2263ee0ffc5484a42a43",
          "lang": appConfig.prefs.getString('lang')
        },*/
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    @required Map<String, dynamic> query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    @required String url,
    Map<String, dynamic> data,
    Map<String, dynamic> query,
  }) async {
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    ) ;
  }

  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  // final Dio _dio;

  // DioHelper({Dio dio}) : _dio = dio ?? Dio();


  Future<Directions> getDirections({
    @required LatLng origin,
    @required LatLng destination,
  }) async {
    final response = await dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': 'AIzaSyBHG1sJAP3tp8iIsHNd_McetWdmn14HDWI',
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    print('error loading points');
    return null;
  }
}
