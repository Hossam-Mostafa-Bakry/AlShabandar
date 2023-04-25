// To parse this JSON data, do
//
//     final deliveryOrdersModel = deliveryOrdersModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DeliveryOrdersModel deliveryOrdersModelFromJson(String str) => DeliveryOrdersModel.fromJson(json.decode(str));

String deliveryOrdersModelToJson(DeliveryOrdersModel data) => json.encode(data.toJson());

class DeliveryOrdersModel {
    DeliveryOrdersModel({
        @required this.statusCode,
        @required this.message,
        @required this.messageCode,
    });

    final int statusCode;
    final List<DeliveryOrderDetail> message;
    final String messageCode;

    factory DeliveryOrdersModel.fromJson(Map<String, dynamic> json) => DeliveryOrdersModel(
        statusCode: json["StatusCode"] == null ? null : json["StatusCode"],
        message: json["Message"] == null ? null : List<DeliveryOrderDetail>.from(json["Message"].map((x) => DeliveryOrderDetail.fromJson(x))),
        messageCode: json["MessageCode"] == null ? null : json["MessageCode"],
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode == null ? null : statusCode,
        "Message": message == null ? null : List<dynamic>.from(message.map((x) => x.toJson())),
        "MessageCode": messageCode == null ? null : messageCode,
    };
}

class DeliveryOrderDetail {
    DeliveryOrderDetail({
        @required this.id,
        @required this.orderNumber,
        @required this.orderStatusId,
        @required this.orderType,
        @required this.paymentType,
        @required this.subTotal,
        @required this.deliveryValue,
        @required this.discountAmount,
        @required this.tax,
        @required this.totalValue,
        @required this.orderDate,
        @required this.latitude,
        @required this.lang,
        @required this.driverId,
        @required this.driverLat,
        @required this.driverLong,
        @required this.orderAddress,
        @required this.orderDetails,
        @required this.allQuantity,
    });

    final String id;
    final String orderNumber;
    final String orderStatusId;
    final String orderType;
    final String paymentType;
    final String subTotal;
    final String deliveryValue;
    final String discountAmount;
    final String tax;
    final String totalValue;
    final DateTime orderDate;
    final dynamic latitude;
    final dynamic lang;
    final String driverId;
    final dynamic driverLat;
    final dynamic driverLong;
    final dynamic orderAddress;
    final List<OrderDetail> orderDetails;
    final int allQuantity;

    factory DeliveryOrderDetail.fromJson(Map<String, dynamic> json) => DeliveryOrderDetail(
        id: json["id"] == null ? null : json["id"],
        orderNumber: json["OrderNumber"] == null ? null : json["OrderNumber"],
        orderStatusId: json["OrderStatusID"] == null ? null : json["OrderStatusID"],
        orderType: json["OrderType"] == null ? null : json["OrderType"],
        paymentType: json["PaymentType"] == null ? null : json["PaymentType"],
        subTotal: json["SubTotal"] == null ? null : json["SubTotal"],
        deliveryValue: json["DeliveryValue"] == null ? null : json["DeliveryValue"],
        discountAmount: json["DiscountAmount"] == null ? null : json["DiscountAmount"],
        tax: json["Tax"] == null ? null : json["Tax"],
        totalValue: json["TotalValue"] == null ? null : json["TotalValue"],
        orderDate: json["OrderDate"] == null ? null : DateTime.parse(json["OrderDate"]),
        latitude: json["Latitude"],
        lang: json["Lang"],
        driverId: json["DriverID"] == null ? null : json["DriverID"],
        driverLat: json["DriverLat"],
        driverLong: json["DriverLong"],
        orderAddress: json["OrderAddress"],
        orderDetails: json["OrderDetails"] == null ? null : List<OrderDetail>.from(json["OrderDetails"].map((x) => OrderDetail.fromJson(x))),
        allQuantity: json["allQuantity"] == null ? null : json["allQuantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "OrderNumber": orderNumber == null ? null : orderNumber,
        "OrderStatusID": orderStatusId == null ? null : orderStatusId,
        "OrderType": orderType == null ? null : orderType,
        "PaymentType": paymentType == null ? null : paymentType,
        "SubTotal": subTotal == null ? null : subTotal,
        "DeliveryValue": deliveryValue == null ? null : deliveryValue,
        "DiscountAmount": discountAmount == null ? null : discountAmount,
        "Tax": tax == null ? null : tax,
        "TotalValue": totalValue == null ? null : totalValue,
        "OrderDate": orderDate == null ? null : orderDate.toIso8601String(),
        "Latitude": latitude,
        "Lang": lang,
        "DriverID": driverId == null ? null : driverId,
        "DriverLat": driverLat,
        "DriverLong": driverLong,
        "OrderAddress": orderAddress,
        "OrderDetails": orderDetails == null ? null : List<dynamic>.from(orderDetails.map((x) => x.toJson())),
        "allQuantity": allQuantity == null ? null : allQuantity,
    };
}

class OrderAddressClass {
    OrderAddressClass({
        @required this.id,
        @required this.isPrimary,
        @required this.title,
        @required this.address,
        @required this.landMark,
        @required this.phone1,
        @required this.phone2,
        @required this.lat,
        @required this.lng,
        @required this.region,
    });

    final String id;
    final String isPrimary;
    final String title;
    final String address;
    final String landMark;
    final String phone1;
    final String phone2;
    final String lat;
    final String lng;
    final String region;

    factory OrderAddressClass.fromJson(Map<String, dynamic> json) => OrderAddressClass(
        id: json["id"] == null ? null : json["id"],
        isPrimary: json["is_primary"] == null ? null : json["is_primary"],
        title: json["title"] == null ? null : json["title"],
        address: json["address"] == null ? null : json["address"],
        landMark: json["land_mark"] == null ? null : json["land_mark"],
        phone1: json["phone1"] == null ? null : json["phone1"],
        phone2: json["phone2"] == null ? null : json["phone2"],
        lat: json["lat"] == null ? null : json["lat"],
        lng: json["lng"] == null ? null : json["lng"],
        region: json["region"] == null ? null : json["region"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "is_primary": isPrimary == null ? null : isPrimary,
        "title": title == null ? null : title,
        "address": address == null ? null : address,
        "land_mark": landMark == null ? null : landMark,
        "phone1": phone1 == null ? null : phone1,
        "phone2": phone2 == null ? null : phone2,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
        "region": region == null ? null : region,
    };
}

class OrderDetail {
    OrderDetail({
        @required this.name,
        @required this.description,
        @required this.price2,
        @required this.image,
        @required this.details,
    });

    final String name;
    final dynamic description;
    final String price2;
    final String image;
    final Details details;

    factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        name: json["name"] == null ? null : json["name"],
        description: json["description"],
        price2: json["Price2"] == null ? null : json["Price2"],
        image: json["Image"] == null ? null : json["Image"],
        details: json["details"] == null ? null : Details.fromJson(json["details"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "description": description,
        "Price2": price2 == null ? null : price2,
        "Image": image == null ? null : image,
        "details": details == null ? null : details.toJson(),
    };
}

class Details {
    Details({
        @required this.orderDetailsId,
        @required this.orderId,
        @required this.branchId,
        @required this.itemId,
        @required this.unitId,
        @required this.quantity,
        @required this.salePrice,
        @required this.subTotal,
        @required this.discount,
        @required this.discountPercent,
        @required this.totalValue,
        @required this.groupId,
        @required this.notes,
        @required this.isEdit,
        @required this.editQuantity,
        @required this.masterId,
        @required this.isReady,
    });

    final String orderDetailsId;
    final String orderId;
    final String branchId;
    final String itemId;
    final dynamic unitId;
    final String quantity;
    final String salePrice;
    final String subTotal;
    final String discount;
    final String discountPercent;
    final String totalValue;
    final dynamic groupId;
    final String notes;
    final String isEdit;
    final dynamic editQuantity;
    final String masterId;
    final dynamic isReady;

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        orderDetailsId: json["OrderDetailsID"] == null ? null : json["OrderDetailsID"],
        orderId: json["OrderID"] == null ? null : json["OrderID"],
        branchId: json["BranchID"] == null ? null : json["BranchID"],
        itemId: json["ItemID"] == null ? null : json["ItemID"],
        unitId: json["UnitID"],
        quantity: json["Quantity"] == null ? null : json["Quantity"],
        salePrice: json["SalePrice"] == null ? null : json["SalePrice"],
        subTotal: json["SubTotal"] == null ? null : json["SubTotal"],
        discount: json["Discount"] == null ? null : json["Discount"],
        discountPercent: json["DiscountPercent"] == null ? null : json["DiscountPercent"],
        totalValue: json["TotalValue"] == null ? null : json["TotalValue"],
        groupId: json["GroupID"],
        notes: json["Notes"] == null ? null : json["Notes"],
        isEdit: json["IsEdit"] == null ? null : json["IsEdit"],
        editQuantity: json["EditQuantity"],
        masterId: json["MasterID"] == null ? null : json["MasterID"],
        isReady: json["IsReady"],
    );

    Map<String, dynamic> toJson() => {
        "OrderDetailsID": orderDetailsId == null ? null : orderDetailsId,
        "OrderID": orderId == null ? null : orderId,
        "BranchID": branchId == null ? null : branchId,
        "ItemID": itemId == null ? null : itemId,
        "UnitID": unitId,
        "Quantity": quantity == null ? null : quantity,
        "SalePrice": salePrice == null ? null : salePrice,
        "SubTotal": subTotal == null ? null : subTotal,
        "Discount": discount == null ? null : discount,
        "DiscountPercent": discountPercent == null ? null : discountPercent,
        "TotalValue": totalValue == null ? null : totalValue,
        "GroupID": groupId,
        "Notes": notes == null ? null : notes,
        "IsEdit": isEdit == null ? null : isEdit,
        "EditQuantity": editQuantity,
        "MasterID": masterId == null ? null : masterId,
        "IsReady": isReady,
    };
}
