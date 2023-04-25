
import 'dart:convert';

class CartModel {
  int id;
  String name;
  String img;
  String description;
  double price;
  double price2;
  double totalPrice;
  int quantity;
  String selectedTypeName;
  String offerName;
  double offerPrice;
  String message;
  List<SubItem> subItems;

  CartModel({
    this.id,
    this.name,
    this.img,
    this.description,
    this.price,
    this.price2,
    this.totalPrice,
    this.quantity,
    this.selectedTypeName,
    this.offerName,
    this.offerPrice,
    this.message,
    this.subItems,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["id"] = this.id;
    data["name"] = this.name;
    data["img"] = this.img;
    data["description"] = this.description;
    data["price"] = this.price;
    data["price2"] = this.price2;
    data["totalPrice"] = this.totalPrice;
    data["quantity"] = this.quantity;
    data["selectedTypeName"] = this.selectedTypeName;
    data["offerName"] = this.offerName;
    data["offerPrice"] = this.offerPrice;
    data["message"] = this.message;
    data["subItems"] = jsonEncode(this.subItems?.map((subItems) => subItems.toJson())?.toList());

    return data;
  }

  CartModel.fromMap(Map<String, dynamic> data, {List<SubItem> subItemList}) {
    id = data['id'];
    name = data['name'];
    img = data['img'];
    description = data["description"];
    price = data['price'];
    price2 = data["price2"];
    totalPrice = data['totalPrice'];
    offerPrice = data["offerPrice"];
    quantity = data['quantity'];
    selectedTypeName = data["selectedTypeName"];
    offerName = data["offerName"];
    message = data["message"];
    subItems = subItemList;

  //   data['subItems'] == null
  //       ? null
  //       : List<SubItem>.from(
  //           data['subItems'].map((x) {
  //             SubItem.fromMap(x);
  //           }),
  //         );
  //   if (data['subItems'] != null) {
  //     subItems = [];
  //     data['subItems'].forEach(
  //       (x) => subItems.add(
  //         SubItem.fromMap(x),
  //       ),
  //     );
  //   }
  }


}

class SubItem {
  int subItemId;
  int subItemQuntity;
  String subItemName;
  String subItemImage;
  double subItemPrice2;

  SubItem({
    this.subItemId,
    this.subItemQuntity,
    this.subItemName,
    this.subItemImage,
    this.subItemPrice2,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['subItemId'] = this.subItemId;
    data['subItemQuntity'] = this.subItemQuntity;
    data['subItemName'] = this.subItemName;
    data['subItemImage'] = this.subItemImage;
    data['subItemPrice2'] = this.subItemPrice2;

    return data;
  }

  SubItem.fromMap(Map<String, dynamic> data) {
    subItemId = data['subItemId'];
    subItemQuntity = data['subItemQuntity'];
    subItemName = data['subItemName'];
    subItemImage = data['subItemImage'];
    subItemPrice2 = data["subItemPrice2"];
  }
}
