import 'package:flutter/material.dart';
import 'package:mishwar/Model/ProductModel.dart';

import '../Model/CartModelLocal.dart';
import '../Model/cart_model.dart';
import '../dbHelper.dart';

class SlmlmProvider extends ChangeNotifier {
  int quantity = 1,
      quantityOffer = 0,
      totalquantity = 0,
      quantityAddOnItems = 0;
  bool isAvilable = false;
  double totalPriceOffer = 0.0, allPrice = 0.0, tax = 0.0;
  String totalofferNames = '';
  SubProductDetail1 subProduct;
  List<SubProductDetail1> selectedOffers = [];
  List<CartMedelLocal> productCarts = [];

  List<SubItem> subItemsList = [];
  DbHelper db = new DbHelper();

  void setAddOnItemQuantity(int v) {
    quantityAddOnItems = v;
    notifyListeners();
  }

  void changeAddingAvilabilty(bool v) {
    isAvilable = v;
    notifyListeners();
  }

  double totalSubItemsPrice = 0;
  int subItemQuantity = 0;

  void changeSubitemQuantity(int quantity) {
    subItemQuantity = quantity;
    notifyListeners();
  }

  void selectTypePrice({SubProductDetail1 subProductParm}) {
    subProduct = subProductParm;
    notifyListeners();
  }

  void selectSubItem({SubItem subItem, bool isChecked}) {
    if (isChecked == true) {
      print("${subItem.subItemId}.....id");

      for (int i = 0; i < subItemsList.length; i++) {
        print("${subItemsList[i].toJson()}...Object");
      }

      if (subItemsList.any((object) => subItem.subItemId == object.subItemId)) {
        subItemsList.forEach((element) {
          if (element.subItemId == subItem.subItemId) {
            element.subItemQuntity++;
            print("${element.subItemQuntity}...quntity");
            print("----------------------------------------");
          }
        });
      } else {
        subItemsList.add(subItem);
      }

      notifyListeners();
    } else {
      if (subItemsList.any((object) => subItem.subItemId == object.subItemId)) {

        for(int i=0; i<subItemsList.length; i++) {
          if (subItemsList[i].subItemId == subItem.subItemId) {

            // case i found the elemnet

            if (subItemsList[i].subItemQuntity > 1) {
              subItemsList[i].subItemQuntity--;
              print("${subItemsList[i].subItemQuntity}...quntity");
              print("----------------------------------------");

            } else if (subItemsList[i].subItemQuntity == 1) {

              print("----------------------------------------");
              subItemsList.remove(subItemsList[i]);
            }
          }
        }
      }
      notifyListeners();
    }
    print(
        "${subItemsList.length}.......length");
    for (int i = 0; i < subItemsList.length; i++) {
      print("${subItemsList[i].toJson()}...Object after");
    }
  }

  getTotal() async {
    List product = await db.allProduct();
    print('product slmlm => ${product}');
    if (product.isEmpty) {
      totalquantity = 0;
      allPrice = 0.0;
      tax = 0.0;
    } else {
      totalquantity = 0;
      allPrice = 0.0;
      tax = 0.0;
      productCarts = [];
      for (int i = 0; i < product.length; i++) {
        CartMedelLocal c = new CartMedelLocal.fromMap(product[i]);
        productCarts.add(c);
        totalquantity += productCarts[i].quantity;
        allPrice += (productCarts[i].totalPrice);
        tax += (productCarts[i].price * productCarts[i].quantity * 15) / 100;
        print(tax.toString());
        print('quan => $totalquantity');
      }
    }
    notifyListeners();
  }

  void a7a({
    int quantityParm,
    bool add,
    int quantityOfferParm,
    SubProductDetail1 selectedOfferParm,
  }) async {
    if (quantityParm != null) {
      quantity = quantityParm;
    }
    if (quantityOfferParm != null) {
      quantityOffer = quantityOfferParm;
    }
    if (selectedOfferParm != null) {
      if (add == true) {
        selectedOffers.add(selectedOfferParm);
      } else {
        selectedOffers.remove(selectedOfferParm);
      }

      totalPriceOffer = 0.0;
      totalofferNames = '';

      for (int i = 0; i < selectedOffers.length; i++) {
        totalPriceOffer += double.parse(selectedOffers[i].price2);

        if (totalofferNames.contains(selectedOffers[i].name)) {
        } else {
          totalofferNames += "${selectedOffers[i].name} + ";
        }
      }

      print("totalPriceOffer=$totalofferNames");
    }
    notifyListeners();
  }

  void clear() {
    quantity = 0;
    quantityOffer = 0;
    totalPriceOffer = 0.0;
    subProduct = null;
    selectedOffers = [];
    notifyListeners();
  }
}
