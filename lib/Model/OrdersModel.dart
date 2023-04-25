/// statusCode : 200
/// messageCode : "SUCCESS"
/// list : [{"userID":13,"orderID":31,"orderNumber":"9","orderDate":"2022-08-09T23:22:00","subTotal":77.0,"discount":0.0,"tax":10.0,"deliveryValue":null,"totalValue":77.0,"allQuantity":7.0,"longitude":"50.21490722573137","latitude":"26.28904416685763","addressID":208,"driverID":0,"driver":null,"driverLat":null,"driverLong":null,"orderStatusId":1,"paymentType":0,"payment":null,"appDeliveryType":2,"appPaymentType":1,"customer":null,"customerID":null,"status":null,"region":"المخيم","regionID":null,"flat":null,"floor":null,"address":"1","phone":"+966593823113","addressLat":"26.285086","addressLong":"50.1905869","notes":"","orderStatus":null,"orderType":null,"orderTypeID":null,"branchId":null,"branch":null,"cashier":null,"tableNo":null,"items":[{"orderDetailsId":99,"orderId":31,"itemName":"فتوش","image":"http://195.181.247.217/Content/images/1.jpg","itemId":1,"unitId":null,"quantity":7.0,"price":null,"salePrice":0.0,"subTotal":88.55,"discount":0.0,"discountPercent":0.0,"totalValue":77.0,"notes":null,"isEdit":false,"editQuantity":null,"masterId":0,"isReady":null}]},{"userID":13,"orderID":32,"orderNumber":"10","orderDate":"2022-08-09T23:22:00","subTotal":77.0,"discount":0.0,"tax":10.0,"deliveryValue":null,"totalValue":77.0,"allQuantity":7.0,"longitude":"50.21490722573137","latitude":"26.28904416685763","addressID":208,"driverID":0,"driver":null,"driverLat":null,"driverLong":null,"orderStatusId":1,"paymentType":0,"payment":null,"appDeliveryType":2,"appPaymentType":1,"customer":null,"customerID":null,"status":null,"region":"المخيم","regionID":null,"flat":null,"floor":null,"address":"1","phone":"+966593823113","addressLat":"26.285086","addressLong":"50.1905869","notes":"","orderStatus":null,"orderType":null,"orderTypeID":null,"branchId":null,"branch":null,"cashier":null,"tableNo":null,"items":[{"orderDetailsId":100,"orderId":32,"itemName":"فتوش","image":"http://195.181.247.217/Content/images/1.jpg","itemId":1,"unitId":null,"quantity":7.0,"price":null,"salePrice":0.0,"subTotal":88.55,"discount":0.0,"discountPercent":0.0,"totalValue":77.0,"notes":null,"isEdit":false,"editQuantity":null,"masterId":0,"isReady":null}]},{"userID":13,"orderID":33,"orderNumber":"11","orderDate":"2022-08-09T23:26:00","subTotal":77.0,"discount":0.0,"tax":10.0,"deliveryValue":null,"totalValue":77.0,"allQuantity":7.0,"longitude":"50.21490722573137","latitude":"26.28904416685763","addressID":208,"driverID":0,"driver":null,"driverLat":null,"driverLong":null,"orderStatusId":1,"paymentType":0,"payment":null,"appDeliveryType":2,"appPaymentType":1,"customer":null,"customerID":null,"status":null,"region":"المخيم","regionID":null,"flat":null,"floor":null,"address":"1","phone":"+966593823113","addressLat":"26.285086","addressLong":"50.1905869","notes":"","orderStatus":null,"orderType":null,"orderTypeID":null,"branchId":null,"branch":null,"cashier":null,"tableNo":null,"items":[{"orderDetailsId":101,"orderId":33,"itemName":"فتوش","image":"http://195.181.247.217/Content/images/1.jpg","itemId":1,"unitId":null,"quantity":7.0,"price":null,"salePrice":0.0,"subTotal":88.55,"discount":0.0,"discountPercent":0.0,"totalValue":77.0,"notes":null,"isEdit":false,"editQuantity":null,"masterId":0,"isReady":null}]},{"userID":13,"orderID":34,"orderNumber":"12","orderDate":"2022-08-09T23:41:00","subTotal":77.0,"discount":0.0,"tax":10.0,"deliveryValue":null,"totalValue":77.0,"allQuantity":7.0,"longitude":"50.21490722573137","latitude":"26.28904416685763","addressID":208,"driverID":0,"driver":null,"driverLat":null,"driverLong":null,"orderStatusId":1,"paymentType":0,"payment":null,"appDeliveryType":2,"appPaymentType":1,"customer":null,"customerID":null,"status":null,"region":"المخيم","regionID":null,"flat":null,"floor":null,"address":"1","phone":"+966593823113","addressLat":"26.285086","addressLong":"50.1905869","notes":"","orderStatus":null,"orderType":null,"orderTypeID":null,"branchId":null,"branch":null,"cashier":null,"tableNo":null,"items":[{"orderDetailsId":102,"orderId":34,"itemName":"فتوش","image":"http://195.181.247.217/Content/images/1.jpg","itemId":1,"unitId":null,"quantity":7.0,"price":null,"salePrice":0.0,"subTotal":88.55,"discount":0.0,"discountPercent":0.0,"totalValue":77.0,"notes":null,"isEdit":false,"editQuantity":null,"masterId":0,"isReady":null}]},{"userID":13,"orderID":35,"orderNumber":"13","orderDate":"2022-08-09T23:41:00","subTotal":77.0,"discount":0.0,"tax":10.0,"deliveryValue":null,"totalValue":77.0,"allQuantity":7.0,"longitude":"50.21490722573137","latitude":"26.28904416685763","addressID":208,"driverID":0,"driver":null,"driverLat":null,"driverLong":null,"orderStatusId":1,"paymentType":0,"payment":null,"appDeliveryType":2,"appPaymentType":1,"customer":null,"customerID":null,"status":null,"region":"المخيم","regionID":null,"flat":null,"floor":null,"address":"1","phone":"+966593823113","addressLat":"26.285086","addressLong":"50.1905869","notes":"","orderStatus":null,"orderType":null,"orderTypeID":null,"branchId":null,"branch":null,"cashier":null,"tableNo":null,"items":[{"orderDetailsId":103,"orderId":35,"itemName":"فتوش","image":"http://195.181.247.217/Content/images/1.jpg","itemId":1,"unitId":null,"quantity":7.0,"price":null,"salePrice":0.0,"subTotal":88.55,"discount":0.0,"discountPercent":0.0,"totalValue":77.0,"notes":null,"isEdit":false,"editQuantity":null,"masterId":0,"isReady":null}]}]

class OrdersModel {
  OrdersModel({
    this.statusCode,
    this.messageCode,
    this.list,
  });

  OrdersModel.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    messageCode = json['messageCode'];
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list.add(OrdersList.fromJson(v));
      });
    }
  }

  num statusCode;
  String messageCode;
  List<OrdersList> list;

}

/// userID : 13
/// orderID : 31
/// orderNumber : "9"
/// orderDate : "2022-08-09T23:22:00"
/// subTotal : 77.0
/// discount : 0.0
/// tax : 10.0
/// deliveryValue : null
/// totalValue : 77.0
/// allQuantity : 7.0
/// longitude : "50.21490722573137"
/// latitude : "26.28904416685763"
/// addressID : 208
/// driverID : 0
/// driver : null
/// driverLat : null
/// driverLong : null
/// orderStatusId : 1
/// paymentType : 0
/// payment : null
/// appDeliveryType : 2
/// appPaymentType : 1
/// customer : null
/// customerID : null
/// status : null
/// region : "المخيم"
/// regionID : null
/// flat : null
/// floor : null
/// address : "1"
/// phone : "+966593823113"
/// addressLat : "26.285086"
/// addressLong : "50.1905869"
/// notes : ""
/// orderStatus : null
/// orderType : null
/// orderTypeID : null
/// branchId : null
/// branch : null
/// cashier : null
/// tableNo : null
/// items : [{"orderDetailsId":99,"orderId":31,"itemName":"فتوش","image":"http://195.181.247.217/Content/images/1.jpg","itemId":1,"unitId":null,"quantity":7.0,"price":null,"salePrice":0.0,"subTotal":88.55,"discount":0.0,"discountPercent":0.0,"totalValue":77.0,"notes":null,"isEdit":false,"editQuantity":null,"masterId":0,"isReady":null}]

class OrdersList {

  OrdersList.fromJson(dynamic json) {
    // userID = json['userID'];
    orderID = json['orderID'];
    orderNumber = json['orderNumber'];
    orderDate = json['orderDate'];
    subTotal = json['subTotal'];
    discount = json['discount'];
    tax = json['tax'];
    deliveryValue = json['deliveryValue'];
    totalValue = json['totalValue'];
    allQuantity = json['allQuantity'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    addressID = json['addressID'];
    driverID = json['driverID'];
    // driver = json['driver'];
    driverLat = json['driverLat'];
    driverLong = json['driverLong'];
    orderStatusId = json['orderStatusId'];
    paymentType = json['paymentType'];
    payment = json['payment'];
    appDeliveryType = json['appDeliveryType'];
    appPaymentType = json['appPaymentType'];
    customer = json['customer'];
    customerID = json['customerID'];
    status = json['status'];
    region = json['region'];
    // regionID = json['regionID'];
    flat = json['flat'];
    floor = json['floor'];
    address = json['address'];
    phone = json['phone'];
    addressLat = json['addressLat'];
    addressLong = json['addressLong'];
    notes = json['notes'];
    orderStatus = json['orderStatus'];
    // orderType = json['orderType'];
    // orderTypeID = json['orderTypeID'];
    branchId = json['branchId'];
    branch = json['branch'];
    // cashier = json['cashier'];
    // tableNo = json['tableNo'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items.add(Items.fromJson(v));
      });
    }
  }

  // String userID;
  int orderID;
  int orderNumber;
  String orderDate;
  num subTotal;
  num discount;
  num tax;
  dynamic deliveryValue;
  num totalValue;
  num allQuantity;
  String longitude;
  String latitude;
  int addressID;
  int driverID;
  // dynamic driver;
  dynamic driverLat;
  dynamic driverLong;
  num orderStatusId;
  String paymentType;
  dynamic payment;
  num appDeliveryType;
  num appPaymentType;
  dynamic customer;
  dynamic customerID;
  dynamic status;
  String region;
  // dynamic regionID;
  String flat;
  String floor;
  String address;
  String phone;
  String addressLat;
  String addressLong;
  String notes;
  String orderStatus;
  // dynamic orderType;
  // dynamic orderTypeID;
  dynamic branchId;
  dynamic branch;
  // dynamic cashier;
  // dynamic tableNo;
  List<Items> items;


}

/// orderDetailsId : 99
/// orderId : 31
/// itemName : "فتوش"
/// image : "http://195.181.247.217/Content/images/1.jpg"
/// itemId : 1
/// unitId : null
/// quantity : 7.0
/// price : null
/// salePrice : 0.0
/// subTotal : 88.55
/// discount : 0.0
/// discountPercent : 0.0
/// totalValue : 77.0
/// notes : null
/// isEdit : false
/// editQuantity : null
/// masterId : 0
/// isReady : null

class Items {
  Items({
    this.orderDetailsId,
    this.orderId,
    this.itemName,
    this.image,
    this.itemId,
    this.unitId,
    this.quantity,
    this.price,
    this.salePrice,
    this.subTotal,
    this.discount,
    this.discountPercent,
    this.totalValue,
    this.notes,
    this.isEdit,
    this.editQuantity,
    this.masterId,
    this.isReady,
  });

  Items.fromJson(dynamic json) {
    orderDetailsId = json['orderDetailsId'];
    orderId = json['orderId'];
    itemName = json['itemName'];
    image = json['image'];
    itemId = json['itemId'];
    unitId = json['unitId'];
    quantity = json['quantity'];
    price = json['price'];
    salePrice = json['salePrice'];
    subTotal = json['subTotal'];
    discount = json['discount'];
    discountPercent = json['discountPercent'];
    totalValue = json['totalValue'];
    notes = json['notes'];
    isEdit = json['isEdit'];
    editQuantity = json['editQuantity'];
    masterId = json['masterId'];
    isReady = json['isReady'];
  }

  num orderDetailsId;
  num orderId;
  String itemName;
  String image;
  num itemId;
  dynamic unitId;
  num quantity;
  dynamic price;
  num salePrice;
  num subTotal;
  num discount;
  num discountPercent;
  num totalValue;
  dynamic notes;
  bool isEdit;
  dynamic editQuantity;
  num masterId;
  dynamic isReady;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderDetailsId'] = orderDetailsId;
    map['orderId'] = orderId;
    map['itemName'] = itemName;
    map['image'] = image;
    map['itemId'] = itemId;
    map['unitId'] = unitId;
    map['quantity'] = quantity;
    map['price'] = price;
    map['salePrice'] = salePrice;
    map['subTotal'] = subTotal;
    map['discount'] = discount;
    map['discountPercent'] = discountPercent;
    map['totalValue'] = totalValue;
    map['notes'] = notes;
    map['isEdit'] = isEdit;
    map['editQuantity'] = editQuantity;
    map['masterId'] = masterId;
    map['isReady'] = isReady;
    return map;
  }
}
