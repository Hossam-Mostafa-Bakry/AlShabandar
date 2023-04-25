// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  AddressModel(
      {this.id,
      this.isPrimary,
      this.title,
      this.address,
      this.landMark,
      this.phone1,
      this.phone2,
      this.flat,
      this.floor,
      this.lat,
      this.lng,
      this.region,
      this.regionId,
      this.createdAt,
      this.deliveryFee});

  String id;
  String isPrimary;
  String title;
  String address;
  String landMark;
  String phone1;
  dynamic phone2;
  String flat;
  String floor;
  String lat;
  String lng;
  String region;
  int regionId;
  DateTime createdAt;
  final String deliveryFee;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["addressId"].toString(),
        isPrimary: json["isPrimary"].toString(),
        title: json["title"],
        landMark: json["landMark"],
        flat: json["flat"],
        floor: json["floor"],
        lat: json["latitude"],
        lng: json["longitude"],
        region: json["region"],
        regionId: json["regionId"],
        createdAt: DateTime.parse(json["createdDate"]),
        deliveryFee: json["deliveryCost"] == null ? null : json["deliveryCost"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "addressId": id,
        "isPrimary": isPrimary,
        "title": title,
        "landMark": landMark,
        "flat": flat,
        "floor": floor,
        "latitude": lat,
        "longitude": lng,
        "region": region,
        "regionId": regionId,
        "createdDate": createdAt.toIso8601String(),
        "deliveryCost": deliveryFee == null ? null : deliveryFee,
      };
}
