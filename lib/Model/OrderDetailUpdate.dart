/// StatusCode : 200
/// MessageCode : "SUCCESS"
/// List : [{"orderDetailsId":79685,"OrderId":31584,"ItemName":"صحن فتوش","ItemId":1,"UnitId":null,"Quantity":4,"Price":11,"SubTotal":50.6,"Discount":0,"DiscountPercent":0,"TotalValue":44,"Notes":null,"IsEdit":false,"EditQuantity":null,"MasterId":0,"IsReady":null}]

class OrderDetailUpdate {

  OrderDetailUpdate.fromJson(dynamic json) {
    statusCode = json['StatusCode'];
    messageCode = json['MessageCode'];
    if (json['List'] != null) {
      list = [];
      json['List'].forEach((v) {
        list.add(OrderDetailNew.fromJson(v));
      });
    }
  }

  int statusCode;
  String messageCode;
  List<OrderDetailNew> list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = statusCode;
    map['MessageCode'] = messageCode;
    if (list != null) {
      map['List'] = list.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// orderDetailsId : 79685
/// OrderId : 31584
/// ItemName : "صحن فتوش"
/// ItemId : 1
/// UnitId : null
/// Quantity : 4
/// Price : 11
/// SubTotal : 50.6
/// Discount : 0
/// DiscountPercent : 0
/// TotalValue : 44
/// Notes : null
/// IsEdit : false
/// EditQuantity : null
/// MasterId : 0
/// IsReady : null

class OrderDetailNew {

  OrderDetailNew.fromJson(dynamic json) {
    orderDetailsId = json['orderDetailsId'];
    orderId = json['OrderId'];
    itemName = json['ItemName'];
    itemId = json['ItemId'];
    unitId = json['UnitId'];
    quantity = json['Quantity'];
    price = json['Price'];
    subTotal = json['SubTotal'];
    discount = json['Discount'];
    discountPercent = json['DiscountPercent'];
    totalValue = json['TotalValue'];
    notes = json['Notes'];
    isEdit = json['IsEdit'];
    editQuantity = json['EditQuantity'];
    masterId = json['MasterId'];
    isReady = json['IsReady'];
  }

  int orderDetailsId;
  int orderId;
  String itemName;
  int itemId;
  dynamic unitId;
  int quantity;
  int price;
  double subTotal;
  int discount;
  int discountPercent;
  int totalValue;
  dynamic notes;
  bool isEdit;
  dynamic editQuantity;
  int masterId;
  dynamic isReady;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderDetailsId'] = orderDetailsId;
    map['OrderId'] = orderId;
    map['ItemName'] = itemName;
    map['ItemId'] = itemId;
    map['UnitId'] = unitId;
    map['Quantity'] = quantity;
    map['Price'] = price;
    map['SubTotal'] = subTotal;
    map['Discount'] = discount;
    map['DiscountPercent'] = discountPercent;
    map['TotalValue'] = totalValue;
    map['Notes'] = notes;
    map['IsEdit'] = isEdit;
    map['EditQuantity'] = editQuantity;
    map['MasterId'] = masterId;
    map['IsReady'] = isReady;
    return map;
  }
}
