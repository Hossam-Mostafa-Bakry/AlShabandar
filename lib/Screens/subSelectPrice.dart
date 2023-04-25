import 'package:flutter/material.dart';
import 'package:mishwar/Model/CartModelLocal.dart';
import 'package:mishwar/Model/ProductModel.dart';
import 'package:mishwar/Screens/slmlmProvider.dart';
import 'package:provider/provider.dart';

import '../dbHelper.dart';
import '../main.dart';

class SubSelectPrice extends StatefulWidget {
  final SubProductDetail1 subProduct;

  SubSelectPrice({Key key, this.subProduct}) : super(key: key);

  @override
  _SubSelectPriceState createState() => _SubSelectPriceState();
}

class _SubSelectPriceState extends State<SubSelectPrice> {
  home h = home();
  DbHelper dbHelper = new DbHelper();
  List dataLocal = [];
  bool isChecked = false;
  SlmlmProvider slmlmProvider;

  @override
  void initState() {
    slmlmProvider = Provider.of<SlmlmProvider>(context, listen: false);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,

      child: Column(
        children: [
          InkWell(
            onTap: () async {
              // Provider.of<SlmlmProvider>(context, listen: false)
              //     .selectTypePrice(
              //   subProductParm: widget.subProduct,
              // );
              //
              // CartMedelLocal p1 = new CartMedelLocal({
              //   "id": int.parse(widget.subProduct.id),
              //   "name": widget.subProduct.name,
              //   "img": widget.subProduct.image,
              //   "description": widget.subProduct.description,
              //   "price": double.parse(widget.subProduct.price),
              //   "offerPrice": Provider.of<SlmlmProvider>(context, listen: false)
              //       .totalPriceOffer,
              //   "price2": double.parse(widget.subProduct.price2),
              //   "totalPrice": double.parse(
              //       Provider.of<SlmlmProvider>(context, listen: false)
              //           .subProduct
              //           .price2),
              //   "quantity": 1,
              //   "selectedTypeName": 'subItem',
              //   "offerName": Provider.of<SlmlmProvider>(context, listen: false)
              //       .totalofferNames,
              //   'message': '',
              // });
              //
              // if (isChecked == false) {
              //   setState(() {
              //     isChecked = true;
              //   });
              //   await dbHelper.addToCart(p1);
              // } else {
              //   setState(() {
              //     isChecked = false;
              //   });
              //   loadData();
              //   setState(() {
              //     dbHelper.delete(int.parse(widget.subProduct.id));
              //   });
              // }
              // print(
              //     'leee => ${Provider.of<SlmlmProvider>(context, listen: false).subItemsList.length}');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // width: MediaQuery.of(context).size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /*Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(h.mainColor),
                              width: 2),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(40),
                          child: widget.subProduct.image ==
                              null
                              ? Image.asset(
                            "images/no-img.jpg",
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                          )
                              : FadeInImage
                              .assetNetwork(
                            placeholder:
                            "images/Spinner.gif",
                            image: widget.subProduct.image ==
                                null
                                ? ""
                                : widget.subProduct.image,
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),*/

                    ],
                  ),
                ),
                /*Row(
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
                                  if (widget.subProduct != null) {
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
                                      widget.totalPrice = widget.quantity * double.parse(widget.product.price2);
                                      slmlmProvider.a7a(quantityParm: widget.quantity,
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
                                  print('quun : ${widget.quantity}');
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Consumer<SlmlmProvider>(builder: (context, ch, _) {
                      return Text(
                        '${widget.totalPrice} ' + DemoLocalizations.of(context).title['currency'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      );

                    }),
                    // Consumer<SlmlmProvider>(builder: (context, ch, _) {
                    //   if (ch.subProduct == null || widget.productoffer != null) {
                    //     return Text(
                    //       '${widget.totalPrice} ' +
                    //           DemoLocalizations.of(context).title['currency'],
                    //       style: TextStyle(
                    //         fontSize: 14,
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     );
                    //   } else {
                    //     return Text(
                    //       '${double.parse(ch.subProduct.price2) * widget.quantity} ' +
                    //           DemoLocalizations.of(context).title['currency'],
                    //       style: TextStyle(
                    //         fontSize: 14,
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     );
                    //   }
                    // }),
                  ],
                ),*/
                /*Consumer<SlmlmProvider>(
                  builder: (context, ch, _) => Checkbox(
                    value: isChecked,
                    onChanged: (bool value) async{

                      Provider.of<SlmlmProvider>(context, listen: false)
                          .selectTypePrice(
                        subProductParm: widget.subProduct,
                      );

                      CartMedelLocal p1 = new CartMedelLocal({
                        "id": int.parse(widget.subProduct.id),
                        "name": widget.subProduct.name,
                        "img": widget.subProduct.image,
                        "description": widget.subProduct.description,
                        "price": double.parse(widget.subProduct.price),
                        "offerPrice": Provider.of<SlmlmProvider>(context, listen: false)
                            .totalPriceOffer,
                        "price2": double.parse(widget.subProduct.price2),
                        "totalPrice": double.parse(
                            Provider.of<SlmlmProvider>(context, listen: false)
                                .subProduct
                                .price2),
                        "quantity": 1,
                        "selectedTypeName": 'subItem',
                        "offerName": Provider.of<SlmlmProvider>(context, listen: false)
                            .totalofferNames,
                        'message': '',
                      });
                      setState(() {
                        isChecked = value;
                      });

                      if (isChecked) {

                        await dbHelper.addToCart(p1);
                      } else {

                        loadData();
                        setState(() {
                          dbHelper.delete(int.parse(widget.subProduct.id));
                        });
                      }
                      print(
                          'leee => ${Provider.of<SlmlmProvider>(context, listen: false).subItemsList.length}');
                    },
                    activeColor: Color(0xffD4252F),
                  ),
                ),*/
                // Consumer<SlmlmProvider>(
                //   builder: (context, ch, _) => Radio(
                //     value: widget.subProduct,
                //     groupValue: ch.subProduct,
                //     onChanged: (val) {
                //       print(val);
                //       ch.selectTypePrice(subProductParm: val);
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  loadData() async {
    dataLocal = await dbHelper.allProduct();
    setState(() {});
  }
}
