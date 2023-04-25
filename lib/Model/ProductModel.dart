import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

import '../app/AppConfig.dart';
import '../lang/app_LocalizationDeledate.dart';

class ProductModel {
  ProductModel({
    @required this.statusCode,
    @required this.message,
    @required this.messageCode,
  });

  final int statusCode;
  final List<ProductDetail> message;
  final String messageCode;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        message: json["message"] == null
            ? null
            : List<ProductDetail>.from(
                json["message"].map((x) => ProductDetail.fromJson(x))),
        messageCode: json["messageCode"] == null ? null : json["messageCode"],
      );
}

class ProductDetail {
  ProductDetail({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.foodCategoryId,
    @required this.price,
    @required this.price2,
    @required this.image,
    @required this.haveChilds,
    @required this.promotionItems,
    @required this.haveOffers,
    @required this.offerItems,
  });

  final String id;
  final String name;
  final String description;
  final String foodCategoryId;
  final String price;
  final String price2;
  final String image;
  final bool haveChilds;
  final List<SubProductDetail1> promotionItems;
  final bool haveOffers;
  final List<SubProductDetail1> offerItems;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        id: json["foodItemId"] == null ? null : json["foodItemId"].toString(),
        name: json["nameAr"] == null
            ? null
            : appConfig.cApp.appLocale == Locale("en")
                ? json["nameEn"]
                : json["nameAr"],
        description: json["descriptionAr"] == null
            ? null
            : appConfig.cApp.appLocale == Locale("en")
                ? json["descriptionEn"]
                : json["descriptionAr"],
        foodCategoryId: json["foodCategoryId"] == null
            ? null
            : json["foodCategoryId"].toString(),
        price: json["price"] == null ? null : json["price"].toString(),
        price2: json["price2"] == null ? null : json["price2"].toString(),
        image: json["image"] == null ? null : json["image"],
        // haveChilds: json["haveChilds"] == null ? null : json["haveChilds"],
    promotionItems: json["addonItems"] == null
            ? null
            : List<SubProductDetail1>.from(
                json["promotionItems"].map(
                  (x) => SubProductDetail1.fromJson(x),
                ),
              ),
        // haveOffers: json["haveOffers"] == null ? null : json["haveOffers"],
        offerItems: json["offerItems"] == null
            ? null
            : List<SubProductDetail1>.from(
                json["offerItems"].map(
                  (x) => SubProductDetail1.fromJson(x),
                ),
              ),
      );
}


class SubProductDetail1 {
  SubProductDetail1({
    @required this.id,
    @required this.masterId,
    @required this.name,
    @required this.description,
    @required this.foodCategoryId,
    @required this.price,
    @required this.price2,
    @required this.image,
  });

  final String id;
  final String masterId;
  final String name;
  final String description;
  final String foodCategoryId;
  final String price;
  final String price2;
  final String image;

  factory SubProductDetail1.fromJson(Map<String, dynamic> json) =>
      SubProductDetail1(
        id: json["promoItemId"] == null ? null : json["promoItemId"].toString(),
        masterId: json["masterId"] == null ? null : json["masterId"].toString(),
        name: json["nameAr"] == null
            ? null
            : appConfig.cApp.appLocale == Locale("en")
                ? json["nameEn"]
                : json["nameAr"],
        description: json["description"] == null ? null : json["description"], // return null
        foodCategoryId: json["foodCategoryId"] == null
            ? null
            : json["foodCategoryId"].toString(),
        price: json["offerPrice"] == null ? null : json["offerPrice"].toString(),
        price2: json["offerPrice"] == null ? null : json["offerPrice"].toString(),
        image: json["image"] == null ? null : json["image"],
      );
}

// class SubProductDetail1 {
//   SubProductDetail1({
//     @required this.id,
//     @required this.masterId,
//     @required this.name,
//     @required this.description,
//     @required this.foodCategoryId,
//     @required this.price,
//     @required this.price2,
//     @required this.image,
//   });
//
//   final String id;
//   final String masterId;
//   final String name;
//   final String description;
//   final String foodCategoryId;
//   final String price;
//   final String price2;
//   final String image;
//
//   factory SubProductDetail1.fromJson(Map<String, dynamic> json) =>
//       SubProductDetail1(
//         id: json["id"] == null ? null : json["id"].toString(),
//         masterId: json["masterId"] == null ? null : json["masterId"].toString(),
//         name: json["nameAr"] == null
//             ? null
//             : appConfig.cApp.appLocale == Locale("en")
//                 ? json["nameEn"]
//                 : json["nameAr"],
//         description: json["description"] == null ? null : json["description"], // return null
//         foodCategoryId: json["foodCategoryId"] == null
//             ? null
//             : json["foodCategoryId"].toString(),
//         price: json["price"] == null ? null : json["price"].toString(),
//         price2: json["price2"] == null ? null : json["price2"].toString(),
//         image: json["image"] == null ? null : json["image"],
//       );
// }