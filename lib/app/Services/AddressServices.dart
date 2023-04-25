import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mishwar/Model/AddressModel.dart';
import 'package:mishwar/Model/RegionModel.dart';
import '../../Model/Region.dart';
import 'GlobalVariables.dart';

class AddressServices {
  String baseURL = GlobalVariables.url;

  Future<List<Region>> getRegions() async {
    var url = "${baseURL}/Region/GetRegions";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200 && response.body != null) {
        // print("region response: ${response.body}");
        final List regionList = json.decode(response.body);

        return regionList.map((e) => Region.fromJson(e)).toList();
      }
    } catch (error) {
      print('$error,,,,error fetch region');
    }
  }

Future<List<RegionDetail>> GetRegions() async {
  var url = "${GlobalVariables.URL}/address/Regions";
  try {
    final response =
    await http.post(Uri.parse(url), headers: await getHeader());
    if (response.statusCode == 200 && response.body != null) {
      List slideritems =
      json.decode(utf8.decode(response.bodyBytes))["Message"];
      return slideritems.map((e) => RegionDetail.fromJson(e)).toList();
    }
  } catch (e) {
    print('$e,,,,error search doctors');
  }
}

  Future<Map<String, dynamic>> addAddressService({
    var user_id,
    var title,
    var region,
    var mark,
    var lat,
    var lng,
    var region_id,
    var floor,
    var flat,
  }) async {
    var body = {
      "UserId" : user_id,
      "Title": title,
      "Flat": flat,
      "Floor": floor,
      "LandMark": mark,
      "Latitude": lat,
      "Longitude": lng,
      "Region": region,
      "RegionId": region_id,
    };
    print(body);
    print("pppppppppppppppppppppppppppp");
    try {
      final responce = await http.post(
        Uri.parse("${baseURL}/Address/CreateAddress"),
        body: json.encode(body),
        headers: await getHeader(),
      );
      print(responce.statusCode);
      print(responce.body);
      print(user_id);
      if (responce.body.isNotEmpty) {
        return json.decode(responce.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<AddressModel>> GetAddresses(var user_id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseURL/Address/GetAddressesByUserID?UserId=$user_id"),
      );
      print("address: ${response.body}");
      if (response.statusCode == 200 && response.body != null) {
        List slideritems =
            json.decode(utf8.decode(response.bodyBytes));
        print('${response.body}');
        return slideritems.map((e) => AddressModel.fromJson(e)).toList();
      }
    } catch (e) {
      print('$e,,,,error search doctors');
    }
  }

  Future<Map<String, dynamic>> SetPrimaryAddress(var id) async {
    String url = baseURL + "/address/SetPrimary";
    var body = {"address_id": id};
    try {
      final responce = await http.post(Uri.parse(url),
          body: json.encode(body), headers: await getHeader());
      if (responce.body.isNotEmpty) {
        print(responce.body);
        return json.decode(responce.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> setPrimaryaddress(String userId, String addressID) async {
    String url =
        baseURL + '/Address/SetPrimary?user_id=$userId&address_id=$addressID';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (error) {
      print('$error,,,,error set primary');
    }
  }

  Future<Map<String, dynamic>> deleteAddress(var id) async {
    String url = baseURL + "/address/Delete";
    var body = {"address_id": id};
    try {
      final responce = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: await getHeader(),
      );
      if (responce.body.isNotEmpty) {
        print(responce.body);
        return json.decode(responce.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Map<String, dynamic>> deleteAddressService(String addressId) async {
    try{
      final responce = await http.get(Uri.parse(baseURL + "/Address/DeleteAddress?address_id=$addressId"),);
      if(responce.statusCode == 200 ) {
        debugPrint(responce.body.toString());
        return json.decode(responce.body);
      }
    }catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> updateAddress({
    var address_id,
    var title,
    var region,
    var mark,
    var lat,
    var lng,
    var region_id,
    var floor,
    var flat,
  }) async {
    var body = {
      "Title": title,
      "AddressId": address_id,
      "Flat": flat,
      "Floor": floor,
      "LandMark": mark,
      "Latitude": lat,
      "Longitude": lng,
      "Region": region,
      "RegionId": region_id
    };
    print(body);
    print("pppppppppppppppppppppppppppp");
    try {
      final responce = await http.post(
        Uri.parse("${baseURL}/Address/EditAddress"),
        body: json.encode(body),
        headers: await getHeader(),
      );
      debugPrint("update address response: ${responce.statusCode}");
      if (responce.body.isNotEmpty) {
        debugPrint("update address response body: ${responce.body}");

        return json.decode(responce.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}



/*  Future<Map<String, dynamic>> addAddressService2(
    var user_id,
    var title,
    var address,
    var mark,
    var lat,
    var lng,
    phone,
    var phone2,
    var region_id,
  ) async {
    String url = "${GlobalVariables.URL}/address/Add";

    var body = {
      "user_id": user_id,
      "title": title,
      "address": address,
      "land_mark": mark,
      "lat": lat,
      "lng": lng,
      "phone1": phone,
      "phone2": phone2,
      "region_id": region_id,
    };
    print(body);
    print("pppppppppppppppppppppppppppp");
    try {
      final responce = await http.post(Uri.parse(url),
          body: json.encode(body), headers: await getHeader());
      if (responce.body.isNotEmpty) {
        print(responce.body);
        return json.decode(responce.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }*/
