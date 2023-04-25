// To parse this JSON data, do
//
//     final getAllPromosModel = getAllPromosModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetAllPromosModel getAllPromosModelFromJson(String str) => GetAllPromosModel.fromJson(json.decode(str));

String getAllPromosModelToJson(GetAllPromosModel data) => json.encode(data.toJson());

class GetAllPromosModel {
  GetAllPromosModel({
    @required this.statusCode,
    @required this.message,
    @required this.messageCode,
  });

  final int statusCode;
  final List<Message> message;
  final String messageCode;

  factory GetAllPromosModel.fromJson(Map<String, dynamic> json) => GetAllPromosModel(
    statusCode: json["StatusCode"] == null ? null : json["StatusCode"],
    message: json["Message"] == null ? null : List<Message>.from(json["Message"].map((x) => Message.fromJson(x))),
    messageCode: json["MessageCode"] == null ? null : json["MessageCode"],
  );

  Map<String, dynamic> toJson() => {
    "StatusCode": statusCode == null ? null : statusCode,
    "Message": message == null ? null : List<dynamic>.from(message.map((x) => x.toJson())),
    "MessageCode": messageCode == null ? null : messageCode,
  };
}

class Message {

  Message({
    @required this.title,
    @required this.description,
    @required this.image,
  });

  final String title;
  final String description;
  final String image;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "image": image == null ? null : image,
  };

}
