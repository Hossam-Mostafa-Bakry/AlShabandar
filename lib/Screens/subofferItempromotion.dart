import 'package:flutter/material.dart';
import 'package:mishwar/Model/ProductModel.dart';
import 'package:mishwar/Model/PromotionItemsModel.dart';
import 'package:mishwar/Screens/slmlmProvider.dart';

import 'package:mishwar/lang/app_Localization.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class SubOfferItemPromotion extends StatefulWidget {
  final SubProductDetail1 productoffer;
  final Message product;
  double totalPrice;
  int quantity;

  SubOfferItemPromotion({
    Key key,
    this.totalPrice,
    this.productoffer,
    this.quantity,
    this.product,
  }) : super(key: key);

  @override
  State<SubOfferItemPromotion> createState() => _SubOfferItemPromotionState();
}

class _SubOfferItemPromotionState extends State<SubOfferItemPromotion> {
  final home h = new home();
  SlmlmProvider slmlmProvider;

  @override
  void initState() {
    slmlmProvider = Provider.of<SlmlmProvider>(context, listen: false);
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
                      onTap: () {
                        setState(() {
                          if (widget.productoffer != null) {
                            if (widget.quantity > 0) {
                              widget.quantity -= 1;
                              widget.totalPrice = widget.quantity *
                                  double.parse(widget.productoffer.price2);
                              print(widget.totalPrice);
                              slmlmProvider.a7a(
                                  add: false,
                                  quantityOfferParm: widget.quantity,
                                  selectedOfferParm: widget.productoffer);
                            }
                          } else {
                            if (widget.quantity > 1) {
                              widget.quantity -= 1;
                              widget.totalPrice = widget.quantity *
                                  double.parse(widget.product.price2);
                              slmlmProvider.a7a(
                                quantityParm: widget.quantity,
                              );
                            }
                          }
                        });
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 7),
                    child: Text(
                      "${widget.quantity}",
                      style: TextStyle(
                        fontSize: 18,
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
                      onTap: () {
                        setState(() {
                          if (widget.productoffer != null) {
                            if (widget.quantity < slmlmProvider.quantity) {
                              widget.quantity += 1;
                              widget.totalPrice = widget.quantity *
                                  double.parse(widget.productoffer.price2);
                              slmlmProvider.a7a(
                                add: true,
                                quantityOfferParm: widget.quantity,
                                selectedOfferParm: widget.productoffer,
                              );
                            }
                          } else {
                            widget.quantity += 1;
                            widget.totalPrice = widget.quantity *
                                double.parse(widget.product.price2);
                            slmlmProvider.a7a(
                              quantityParm: widget.quantity,
                            );
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Consumer<SlmlmProvider>(builder: (context, ch, _) {
              if (ch.subProduct == null || widget.productoffer != null) {
                return Text(
                  '${widget.totalPrice} ' +
                      DemoLocalizations.of(context).title['currency'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else {
                return Text(
                  '${double.parse(ch.subProduct.price2) * widget.quantity} ' +
                      DemoLocalizations.of(context).title['currency'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
            }),
          ],
        ),
      ],
    );
  }
}
