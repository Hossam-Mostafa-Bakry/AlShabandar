

class OrderDetails {


  OrderDetails.fromJson(dynamic json) {
    orderId = json['orderId'];
    orderDetailId = json['orderDetailId'];
    itemId = json['itemId'];
    itemName = json['itemName'];
    itemNameAr = json['itemNameAr'];
    salePrice = json['salePrice'];
    quantity = json['quantity'];
    subTotal = json['subTotal'];
    discount = json['discount'];
    discountPercent = json['discountPercent'];
    totalValue = json['totalValue'];
    phone = json['phone'];
    image = json['image'];
    notes = json['notes'];
  }

  int orderId;
  int orderDetailId;
  int itemId;
  String itemName;
  String itemNameAr;
  double salePrice;
  num quantity;
  double subTotal;
  double discount;
  double discountPercent;
  double totalValue;
  String phone;
  String image;
  String notes;

}
