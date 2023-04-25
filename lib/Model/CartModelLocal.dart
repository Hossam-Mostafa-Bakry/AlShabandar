class CartMedelLocal {
  //attributes = fields in table
  int _id;
  String _name;
  String _img;
  String _description;
  double _price;
  double _price2;
  double _totalPrice;
  int _quantity;
  String _selectedTypeName;
  String _offerName;
  double _offerPrice;
  String _message;

  //we will edit subitems later

  //
  // List<SubItem> _subItems;

  CartMedelLocal(dynamic obj) {
    _id = obj['id'];
    _name = obj["name"];
    _img = obj["img"];
    _price = obj["price"];
    _price2 = obj["price2"];
    _totalPrice = obj["totalPrice"];
    _quantity = obj["quantity"];
    _description = obj["description"];
    _offerPrice = obj["offerPrice"];
    _selectedTypeName = obj["selectedTypeName"];
    _offerName = obj["offerName"];
    _message = obj["message"];
    // _subItems = obj['subItems'];
  }

  CartMedelLocal.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _name = data['name'];
    _img = data['img'];
    _description = data["description"];
    _price = data['price'];
    _price2 = data["price2"];
    _totalPrice = data['totalPrice'];
    _offerPrice = data["offerPrice"];
    _quantity = data['quantity'];
    _selectedTypeName = data["selectedTypeName"];
    _offerName = data["offerName"];
    _message = data["message"];
    // _subItems = data['subItems'] == null
    //     ? null
    //     : List<SubItem>.from(
    //         data['subItems'].map((x) {
    //           SubItem.fromMap(x);
    //         }),
    //       );
    // if (data['subItems'] != null) {
    //   _subItems = [];
    //   data['subItems'].forEach(
    //     (x) => subItems.add(
    //       SubItem.fromMap(x),
    //     ),
    //   );
    // }
  }

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'img': _img,
        "description": _description,
        "offerPrice": _offerPrice,
        'price': _price,
        "price2": _price2,
        'totalPrice': _totalPrice,
        'quantity': _quantity,
        "selectedTypeName": _selectedTypeName,
        "offerName": _offerName,
        "message": _message,
        // 'subItems':
        //     _subItems == null ? null : _subItems.map((e) => e.toMap()).toList(),
      };

  int get id => _id;

  String get name => _name;

  String get img => _img;

  String get description => _description;

  double get price => _price;

  double get price2 => _price2;

  double get totalPrice => _totalPrice;

  double get offerPrice => _offerPrice;

  int get quantity => _quantity;

  String get selectedTypeName => _selectedTypeName;

  String get offerName => _offerName;

  String get message => _message;

  // change this subItems variables to list

  // List get subItems => _subItems;
}
/*
class SubItem {
  int _subItemId;
  String _subItemName;
  String _subItemImage;
  double _subItemPrice2;

  SubItem(dynamic obj) {
    _subItemId = obj['subItemId'];
    _subItemName = obj["subItemName"];
    _subItemImage = obj["subItemImage"];
    _subItemPrice2 = obj["subItemPrice2"];
  }

  SubItem.fromMap(Map<String, dynamic> data) {
    _subItemId = data['subItemId'];
    _subItemName = data['subItemName'];
    _subItemImage = data['subItemImage'];
    _subItemPrice2 = data["subItemPrice2"];
  }

  Map<String, dynamic> toMap() => {
        'subItemId': _subItemId,
        'subItemName': _subItemName,
        'subItemImage': _subItemImage,
        "subItemPrice2": _subItemPrice2,
      };

  int get subItemId => _subItemId;

  String get subItemName => _subItemName;

  String get subItemImage => _subItemImage;

  double get subItemPrice2 => _subItemPrice2;
}*/
