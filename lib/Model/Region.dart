class Region {

  num regionId;
  String code;
  String nameAr;
  String nameEn;
  num branchId;
  num deliveryValue;
  bool isActive;
  num insertUser;
  String insertDate;
  String deliveryTime;
  String minimumSales;

  Region.fromJson(dynamic json) {
    regionId = json['regionId'];
    code = json['code'];
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    branchId = json['branchId'];
    deliveryValue = json['deliveryValue'];
    isActive = json['isActive'];
    insertUser = json['insertUser'];
    insertDate = json['insertDate'];
    deliveryTime = json['deliveryTime'];
    minimumSales = json['minimumSales'];
  }

}
