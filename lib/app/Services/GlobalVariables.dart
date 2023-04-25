import 'package:flutter/material.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:mishwar/app/AppConfig.dart';
import 'package:path/path.dart';

class GlobalVariables {

  // http://93.112.4.175/app/
  // static String URL="https://www.edumisr.com/APP_API/Hyper";
  //  static String URL="http://www.mishwar.elmasren.com/api";

  static String URL="http://195.181.247.217/app";


  // static String url = "http://www.appapi.elmasren.com/api";
  static String url = "http://www.shahapi.elmasren.com/api";

}
Future<Map<String,String>> getHeader()async
{
  Map<String,String> header={
    "Content-Type":"application/json",
    "X-Auth-Token":"dfbed9f22f0f2263ee0ffc5484a42a43",
    "lang":appConfig.prefs.getString('lang')
    //appConfig.cApp.appLocale.toString()
  };
  return header;
}