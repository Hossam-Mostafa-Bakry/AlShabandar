// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);
/*

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.statusCode,
    this.categoryDetail,
    this.messageCode,
  });

  int statusCode;
  List<CategoryDetail> categoryDetail;
  String messageCode;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    statusCode: json["StatusCode"],
    categoryDetail: List<CategoryDetail>.from(json["CategoryDetail"].map((x) => CategoryDetail.fromJson(x))),
    messageCode: json["MessageCode"],
  );

  Map<String, dynamic> toJson() => {
    "StatusCode": statusCode,
    "CategoryDetail": List<dynamic>.from(categoryDetail.map((x) => x.toJson())),
    "MessageCode": messageCode,
  };
}

class CategoryDetail {
  CategoryDetail({
    this.id,
    this.parentId,
    this.name,
    this.description,
    this.itemIndex,
    this.isLoloGroup,
    this.isPromotion,
  });

  int id;
  int parentId;
  String name;
  String description;
  int itemIndex;
  dynamic isLoloGroup;
  bool isPromotion;

  factory CategoryDetail.fromJson(Map<String, dynamic> json) => CategoryDetail(
    id: json["id"],
    parentId: json["ParentID"],
    name: json["name"],
    description: json["description"],
    itemIndex: json["ItemIndex"],
    isLoloGroup: json["IsLoloGroup"],
    isPromotion: json["IsPromotion"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ParentID": parentId,
    "name": name,
    "description": description,
    "ItemIndex": itemIndex,
    "IsLoloGroup": isLoloGroup,
    "IsPromotion": isPromotion,
  };
}
*/

import 'package:flutter/material.dart';

import '../app/AppConfig.dart';

/// StatusCode : 200
/// CategoryDetail : [{"id":23,"parentId":0,"name":"Companies Promotions","description":"","itemIndex":2,"isLoloGroup":null,"isPromotion":false},{"id":11,"parentId":0,"name":"Shawerma","description":"","itemIndex":5,"isLoloGroup":null,"isPromotion":false},{"id":9,"parentId":0,"name":"Barbeque","description":"","itemIndex":6,"isLoloGroup":null,"isPromotion":false},{"id":1,"parentId":0,"name":"Apitizers","description":"","itemIndex":7,"isLoloGroup":null,"isPromotion":false},{"id":15,"parentId":0,"name":"kabsa","description":"","itemIndex":11,"isLoloGroup":null,"isPromotion":false},{"id":3,"parentId":0,"name":"Baverages","description":"","itemIndex":13,"isLoloGroup":null,"isPromotion":false},{"id":10,"parentId":0,"name":"Broasted","description":"","itemIndex":14,"isLoloGroup":null,"isPromotion":false},{"id":6,"parentId":0,"name":"Daily Dishes","description":"","itemIndex":15,"isLoloGroup":null,"isPromotion":false},{"id":7,"parentId":0,"name":"Promotion","description":"","itemIndex":16,"isLoloGroup":null,"isPromotion":false},{"id":12,"parentId":0,"name":"Pepsi","description":"","itemIndex":18,"isLoloGroup":null,"isPromotion":false},{"id":14,"parentId":0,"name":"sandwich","description":"","itemIndex":19,"isLoloGroup":null,"isPromotion":false},{"id":20,"parentId":0,"name":"Side Items","description":"","itemIndex":20,"isLoloGroup":null,"isPromotion":false},{"id":2,"parentId":0,"name":"BAKARIES","description":"","itemIndex":21,"isLoloGroup":null,"isPromotion":false},{"id":5,"parentId":0,"name":"Catering","description":"","itemIndex":23,"isLoloGroup":null,"isPromotion":false},{"id":22,"parentId":0,"name":"Company Meals","description":"","itemIndex":26,"isLoloGroup":null,"isPromotion":false}]
/// MessageCode : "SUCCESS"

class CategoryModel {
  CategoryModel({
    this.statusCode,
    this.categoryDetail,
    this.messageCode,
  });

  CategoryModel.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    if (json['categoryDetail'] != null) {
      categoryDetail = [];
      json['categoryDetail'].forEach((v) {
        categoryDetail.add(CategoryDetail.fromJson(v));
      });
    }
    messageCode = json['messageCode'];
  }

  int statusCode;
  List<CategoryDetail> categoryDetail;
  String messageCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    if (categoryDetail != null) {
      map['categoryDetail'] = categoryDetail.map((v) => v.toJson()).toList();
    }
    map['messageCode'] = messageCode;
    return map;
  }
}

/// id : 23
/// parentId : 0
/// name : "Companies Promotions"
/// description : ""
/// itemIndex : 2
/// isLoloGroup : null
/// isPromotion : false

class CategoryDetail {
  int id;
  String name;
  String description;
  String image;

  CategoryDetail.fromJson(Map<String, dynamic> json) {
    id = json['foodCategoryId'];
    name = json["nameAr"] == null
        ? null
        : appConfig.cApp.appLocale == Locale("en")
        ? json["nameEn"]
        : json["nameAr"];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['foodCategoryId'] = id;
    map['name'] = name;
    map['description'] = description;
    map['image'] = image;
    return map;
  }
}
// class CategoryDetail {
//
//   int id;
//   int parentId;
//   String name;
//   String description;
//   int itemIndex;
//   dynamic isLoloGroup;
//   bool isPromotion;
//   String image;
//
//   CategoryDetail.fromJson(dynamic json) {
//     id = json['id'];
//     parentId = json['parentId'];
//     name =  appConfig.cApp.appLocale == Locale("en") ? json['nameEn'] : json['nameAr'];
//     description = json['description'];
//     itemIndex = json['itemIndex'];
//     isLoloGroup = json['isLoloGroup'];
//     isPromotion = json['isPromotion'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['parentId'] = parentId;
//     map['name'] = name;
//     map['description'] = description;
//     map['itemIndex'] = itemIndex;
//     map['isLoloGroup'] = isLoloGroup;
//     map['isPromotion'] = isPromotion;
//     map['image'] = image;
//     return map;
//   }
// }

