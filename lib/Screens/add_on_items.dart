import 'package:flutter/material.dart';
import 'package:mishwar/Model/CartModelLocal.dart';
import 'package:mishwar/Model/ProductModel.dart';
import 'package:mishwar/Screens/slmlmProvider.dart';

import 'package:mishwar/lang/app_Localization.dart';
import 'package:provider/provider.dart';

import '../Model/cart_model.dart';
import '../dbHelper.dart';
import '../main.dart';

class AddOnItemsWidget extends StatefulWidget {
  final SubProductDetail1 subItemProduct;
  final ProductDetail product;
  double subItemTotalPrice;
  int quantity;

  AddOnItemsWidget({
    Key key,
    this.subItemTotalPrice,
    this.subItemProduct,
    this.quantity,
    this.product,
  }) : super(key: key);

  @override
  State<AddOnItemsWidget> createState() => _AddOnItemsWidgetState();
}

class _AddOnItemsWidgetState extends State<AddOnItemsWidget> {
  final home h = new home();
  DbHelper dbHelper = new DbHelper();
  CartMedelLocal p1;
  SlmlmProvider slmlmProvider;
  List dataLocal = [];
  double subItemTotalPrice;

  @override
  void initState() {
    slmlmProvider = Provider.of<SlmlmProvider>(context, listen: false);
    subItemTotalPrice = double.parse(widget.subItemProduct.price2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      border: Border.all(
                        color: Color(h.mainColor),
                        width: 1.0,
                      ),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: InkWell(
                        child: Icon(
                          Icons.remove,
                          color: Color(h.mainColor),
                        ),
                        onTap: () async {

                          if (widget.quantity > 0) {
                            slmlmProvider.selectSubItem(
                              isChecked: false,
                              subItem: SubItem(
                                subItemId: int.parse(widget.subItemProduct.id),
                                subItemQuntity: widget.quantity,
                                subItemName: widget.subItemProduct.name,
                                subItemImage: widget.subItemProduct.image,
                                subItemPrice2:
                                    double.parse(widget.subItemProduct.price2),
                              ),
                            );

                            widget.quantity -= 1;
                            slmlmProvider.quantityAddOnItems--;

                            setState(() {});

                          }

                          /*print('quunSUb 1: ${widget.quantity}');
                        print('subItem 1: ${slmlmProvider.subItemQuantity}');

                        if (widget.quantity > 0) {
                          widget.quantity -= 1;
                          slmlmProvider.quantityAddOnItems--;
                          widget.subItemTotalPrice = widget.quantity *
                              double.parse(widget.subItemProduct.price2);
                          print(
                              'total subitem price${widget.subItemTotalPrice}');

                          setState(() {});
                          p1 = new CartMedelLocal({
                            "id": int.parse(widget.subItemProduct.id),
                            "name": widget.subItemProduct.name,
                            "img": widget.subItemProduct.image,
                            "description": widget.subItemProduct.description,
                            "price": double.parse(widget.subItemProduct.price),
                            "offerPrice": Provider.of<SlmlmProvider>(context,
                                    listen: false)
                                .totalPriceOffer,
                            "price2":
                                double.parse(widget.subItemProduct.price2),
                            "totalPrice": widget.subItemTotalPrice,
                            "quantity": widget.quantity,
                            "selectedTypeName": 'mainProduct',
                            "offerName": Provider.of<SlmlmProvider>(context,
                                    listen: false)
                                .totalofferNames,
                            'message': '',
                          });
                          dbHelper.delete(int.parse(widget.subItemProduct.id));
                          await dbHelper.addToCart(p1);
                        }

                        if (widget.quantity + 1 ==
                            slmlmProvider.subItemQuantity) {
                          slmlmProvider.changeSubitemQuantity(widget.quantity);
                          print('quunSUb 2: ${widget.quantity}');
                          print('subItem 2: ${slmlmProvider.subItemQuantity}');
                        }
                        setState(() {});
                      },*/
                        }),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 7),
                    child: Text(
                      "${widget.quantity}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      border: Border.all(
                        color: Color(h.blueColor),
                        width: 1.0,
                      ),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: InkWell(
                      child: Icon(
                        Icons.add,
                        color: Color(h.blueColor),
                      ),
                      onTap: () async {

                        if (slmlmProvider.quantityAddOnItems <
                            slmlmProvider.quantity) {
                          widget.quantity += 1;
                          slmlmProvider.quantityAddOnItems++;

                          slmlmProvider.selectSubItem(
                            isChecked: true,
                            subItem: SubItem(
                              subItemId: int.parse(widget.subItemProduct.id),
                              subItemName: widget.subItemProduct.name,
                              subItemQuntity: widget.quantity,
                              subItemImage: widget.subItemProduct.image,
                              subItemPrice2:
                                  double.parse(widget.subItemProduct.price2),
                            ),
                          );

                          setState(() {});
                          print(
                              "${slmlmProvider.subItemsList.length}.......length");
                        }
                        /*setState(() {
                          if (slmlmProvider.quantityAddOnItems < slmlmProvider.quantity) {
                            debugPrint("yes");
                            widget.quantity += 1;
                            slmlmProvider.quantityAddOnItems++;

                            widget.subItemTotalPrice = widget.quantity *
                                double.parse(widget.subItemProduct.price2);

                            if (widget.quantity >=
                                slmlmProvider.subItemQuantity) {
                              slmlmProvider.subItemQuantity = widget.quantity;
                            }
                          }
                        });
                        if (widget.quantity == 1) {
                          p1 = new CartMedelLocal({
                            "id": int.parse(widget.subItemProduct.id),
                            "name": widget.subItemProduct.name,
                            "img": widget.subItemProduct.image,
                            "description": widget.subItemProduct.description,
                            "price": double.parse(widget.subItemProduct.price),
                            "offerPrice": Provider.of<SlmlmProvider>(context, listen: false).totalPriceOffer,
                            "price2": double.parse(widget.subItemProduct.price2),
                            "totalPrice": widget.subItemTotalPrice,
                            "quantity": widget.quantity,
                            "selectedTypeName": 'subItem',
                            "offerName": Provider.of<SlmlmProvider>(context,
                                    listen: false)
                                .totalofferNames,
                            'message': '',
                          });
                          loadData();
                          dbHelper.delete(int.parse(widget.subItemProduct.id));
                          await dbHelper.addToCart(p1);
                        } else if (widget.quantity > 1) {
                          p1 = new CartMedelLocal({
                            "id": int.parse(widget.subItemProduct.id),
                            "name": widget.subItemProduct.name,
                            "img": widget.subItemProduct.image,
                            "description": widget.subItemProduct.description,
                            "price": double.parse(widget.subItemProduct.price),
                            "offerPrice": Provider.of<SlmlmProvider>(context, listen: false).totalPriceOffer,
                            "price2": double.parse(widget.subItemProduct.price2),
                            "totalPrice": widget.subItemTotalPrice,
                            "quantity": widget.quantity,
                            "selectedTypeName": 'subItem',
                            "offerName": Provider.of<SlmlmProvider>(context,
                                    listen: false)
                                .totalofferNames,
                            'message': '',
                          });

                          loadData();
                          dbHelper.delete(int.parse(widget.subItemProduct.id));
                          await dbHelper.addToCart(p1);
                          // loadData();
                          // dbHelper.updateCourse(p1);
                        }
                        print('quunSUb : ${widget.quantity}');
                        print('subItem : ${slmlmProvider.subItemQuantity}');
                      */
                      },
                    ),
                  ),
                ],
              ),
            ),
            Consumer<SlmlmProvider>(builder: (context, ch, _) {
              return Text(
                '${widget.subItemTotalPrice == 0 ? widget.subItemProduct.price2 : widget.subItemTotalPrice} ' +
                    DemoLocalizations.of(context).title['currency'],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
              // if (widget.quantity == 0) {
              //   return Text(
              //     '${double.parse(widget.subItemProduct.price2)} ' +
              //         DemoLocalizations.of(context).title['currency'],
              //     style: TextStyle(
              //       fontSize: 12,
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   );
              // } else {
              //   return Text(
              //     '${double.parse(widget.subItemProduct.price2) * widget.quantity} ' +
              //         DemoLocalizations.of(context).title['currency'],
              //     style: TextStyle(
              //       fontSize: 12,
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   );
              // }
            }),
          ],
        ),
      ],
    );
  }

  loadData() async {
    dataLocal = await dbHelper.allProduct();
    setState(() {});
  }
}
