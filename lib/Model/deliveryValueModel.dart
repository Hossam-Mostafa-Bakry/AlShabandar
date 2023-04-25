// To parse this JSON data, do
//
//     final getDeliveryValueModel = getDeliveryValueModelFromJson(jsonString);

import 'package:meta/meta.dart';

class GetDeliveryValueModel {
  GetDeliveryValueModel({
    @required this.statusCode,
    @required this.message,
    @required this.messageCode,
  });

  final int statusCode;
  final String message;
  final String messageCode;

  factory GetDeliveryValueModel.fromJson(Map<String, dynamic> json) =>
      GetDeliveryValueModel(
        statusCode: json["StatusCode"] == null ? null : json["StatusCode"],
        message: json["Message"] == null ? null : json["Message"],
        messageCode: json["MessageCode"] == null ? null : json["MessageCode"],
      );
}
