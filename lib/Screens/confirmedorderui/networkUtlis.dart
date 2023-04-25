import 'dart:developer';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:mishwar/Screens/Splash.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkUtil with ChangeNotifier {
  static final NetworkUtil _instance = NetworkUtil.internal();
  NetworkUtil.internal();
  double preasent = 0.0;
  factory NetworkUtil() => _instance;
  Dio dio = Dio();

  Future<Response> get(
    String url, {
    Map<String, String> headers,
    @required BuildContext context,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> headerss = headers ??
        {
          'Content-Type': 'application/json',
          'X-Auth-Token': 'Bearer ${pref.getString("token")}',
          'Lang': DemoLocalizations.of(context).locale.languageCode,
        };
    var response;
    try {
      dio.options.baseUrl = 'http://93.112.4.175/app/';
      response = await dio.get(url, options: Options(headers: headerss));
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
        log('response: ' + e.response.toString());
      } else {}
    }
    return handleResponse(response, context);
  }

  Future<Response> post(String url,
      {var body, @required BuildContext context}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> headerss = {
      'Content-Type': 'application/json',
      //'X-Auth-Token': '${pref.getString("token")}',
      'X-Auth-Token': 'dfbed9f22f0f2263ee0ffc5484a42a43'
    };
    var response;
    dio.options.baseUrl = 'http://93.112.4.175/app/';
    try {
      response = await dio.post(
        url,
        data: body,
        options: Options(headers: headerss,),
        onSendProgress: (int sent, int total) {
          preasent = ((sent / total * 100));
          log('progress: $preasent ($sent/$total)');
          notifyListeners();
        },
      );
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
        log('response: ' + e.response.toString());
      } else {}
    }
    return handleResponse(response, context);
  }

  Future<Response> handleResponse(
      Response response, BuildContext context) async {
    if (response == null || response.data.runtimeType == String) {
      final result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.none) {
        return Response(
          statusCode: 102,
          data: {
            'mainCode': 0,
            'code': 102,
            'data': null,
            'error': [
              {'key': 'internet', 'value': 'يرجى التحقق من الاتصال بالانترنت'}
            ]
          },
          requestOptions: RequestOptions(path: ''),
        );
      } else {
        return Response(
          statusCode: 102,
          data: {
            'mainCode': 0,
            'code': 103,
            'data': null,
            'error': [
              {'key': 'internet', 'value': 'هناك خطأ يرجى اعادة المجاولة'}
            ]
          },
          requestOptions: RequestOptions(path: ''),
        );
      }
    } else {
      final int statusCode = response.statusCode;
      log('response: ' + response.toString());
      log('statusCode: ' + statusCode.toString());
      preasent = 0;
      if (statusCode >= 200 && statusCode < 300) {
        return response;
      } else if (statusCode == 401) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Splash()),
            (Route<dynamic> route) => false);
        return Response(
          statusCode: 401,
          data: {
            'mainCode': 0,
            'code': 401,
            'data': null,
            'error': [
              {'key': 'internet', 'value': 'انتهت مده التسجيل'}
            ]
          },
          requestOptions: RequestOptions(path: ''),
        );
      } else {
        return response;
      }
    }
  }
}
