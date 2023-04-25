import 'package:flutter/material.dart';
import 'package:mishwar/Model/CartModelLocal.dart';
import 'package:mishwar/Screens/shared/button_ui.dart';
import 'package:mishwar/Screens/slmlmProvider.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:provider/provider.dart';

import '../Model/cart_model.dart';
import '../Services/database_helper.dart';
import '../dbHelper.dart';
import '../main.dart';
import 'HomePage.dart';
import 'sub_item_widget.dart';

class SubItemCart extends StatefulWidget {

  final CartModel c;
  SubItemCart(this.c);

  @override
  State<SubItemCart> createState() => _SubItemCartState();
}

class _SubItemCartState extends State<SubItemCart> {

  home h = new home();
  SlmlmProvider slmlmProvider;
  int quantity;
  List dataLocal = [];
  DbHelper db = new DbHelper();
  DatabaseHelper dbHelper = new DatabaseHelper();

  @override
  void initState() {
    quantity = widget.c.quantity;
    slmlmProvider = Provider.of<SlmlmProvider>(context, listen: false);
    // print("${widget.c.subItems[1].subItemQuntity}... sub item quentity");
    print(widget.c.subItems.isEmpty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 2),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .008,
        bottom: MediaQuery.of(context).size.height * .008,
        left: MediaQuery.of(context).size.width * .05,
        right: MediaQuery.of(context).size.width * .05,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border:
              Border.all(width: 1.0, color: Colors.black12.withOpacity(.05)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(3, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white),
                    width: MediaQuery.of(context).size.width * .25,
                    // height: MediaQuery.of(context).size.height * .132,
                    child: ClipRRect(
                      borderRadius:
                          DemoLocalizations.of(context).locale == Locale("ar")
                              ? BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )
                              : BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                      child: widget.c.img == null
                          ? Image.asset(
                              "images/no-img.jpg",
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height * .132,
                            )
                          : FadeInImage.assetNetwork(
                              placeholder: "images/prodcut4.png",
                              image: widget.c.img == null ? "" : widget.c.img,
                              width: MediaQuery.of(context).size.width * .9,
                              height: MediaQuery.of(context).size.height * .132,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    // height: MediaQuery.of(context).size.height * .132,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .005,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .61,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * .51,
                                child: Text(
                                  widget.c.name,
                                  // widget.c.selectedTypeName != null
                                  //     ? widget.c.selectedTypeName.toString()
                                  //     :
                                  // DemoLocalizations.of(context).title['Offers'],
                                  // widget.c.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    height: 1.0,
                                    fontSize: 12,
                                    color: Color(h.mainColor),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.zero,
                                alignment: Alignment.topLeft,
                                child: InkWell(
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    child: Icon(
                                      Icons.delete,
                                      size: 18,
                                      color: Color(h.mainColor),
                                    ),
                                  ),
                                  onTap: () {
                                    DeleteFromCart(
                                      context,
                                      widget.c.id,
                                      widget.c.quantity,
                                      widget.c.price * widget.c.quantity,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .00),
                        Text(
                          widget.c.message ?? '',
                          style: TextStyle(fontSize: 10),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .61,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.c.price2}" +
                                    ' ' +
                                    DemoLocalizations.of(context)
                                        .title['currency'],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                              widget.c.selectedTypeName != 'subItem'
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print(quantity);
                                            setState(() {
                                              quantity++;
                                            });
                                            print(quantity);

                                            CartModel cartLDBModel =
                                            CartModel(
                                              id: widget.c.id,
                                              name: widget.c.name,
                                              img: widget.c.img,
                                              price: widget.c.price,
                                              price2: widget.c.price2,
                                              description:
                                                  widget.c.description,
                                              totalPrice: widget.c.price2 *
                                                      quantity +
                                                  (widget.c.offerPrice ?? 0),
                                              offerPrice: widget.c.offerPrice,
                                              quantity: quantity,
                                              message: widget.c.message,
                                              subItems: widget.c.subItems,
                                            );
                                            // print(widget.c.id);
                                            // print(widget.c.name);
                                            // print(widget.c.price);
                                            // print(widget.c.price2);
                                            // print(widget.c.description);
                                            // print(widget.c.quantity);
                                            // print(widget.c.offerPrice);
                                            // print(widget.c.totalPrice);
                                            // print(
                                            //     "000000000000000000000000000000000000");

                                            setState(() {
                                              db.updateCourseTable(cartLDBModel);
                                            });
                                            slmlmProvider.getTotal();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 3,
                                                bottom: 3),
                                            // color: Colors.red,
                                            child: Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(1000)),
                                                border: Border.all(
                                                  color: Color(h.blueColor),
                                                  width: 1.0,
                                                ),
                                                color: Colors.white,
                                              ),
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.add,
                                                size: 14,
                                                color: Color(h.blueColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // SizedBox(width: 3,),
                                        Container(
                                          width: 16,
                                          height: 16,
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            quantity.toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        // SizedBox(width: 3,),
                                        InkWell(
                                          onTap: () {
                                            if (quantity > 1) {
                                              setState(() {
                                                quantity--;
                                              });
                                              CartModel cartLDBModel =
                                              CartModel(
                                                id: widget.c.id,
                                                name: widget.c.name,
                                                img: widget.c.img,
                                                price: widget.c.price,
                                                price2: widget.c.price2,
                                                description:
                                                    widget.c.description,
                                                totalPrice: widget.c.price2 *
                                                        quantity +
                                                    (widget.c.offerPrice ?? 0),
                                                offerPrice:
                                                    widget.c.offerPrice,
                                                quantity: quantity,
                                                message: widget.c.message,
                                                subItems: widget.c.subItems,
                                              );
                                              setState(() {
                                                db.updateCourseTable(cartLDBModel);
                                                // updateTotal(-1, -c.price);
                                              });
                                              slmlmProvider.getTotal();
                                            } else {
                                              DeleteFromCart(
                                                context,
                                                widget.c.id,
                                                widget.c.quantity,
                                                widget.c.totalPrice,
                                              );
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 4,
                                                right: 10,
                                                top: 3,
                                                bottom: 3),
                                            // color: Colors.red,

                                            child: Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(500)),
                                                  border: Border.all(
                                                      color: Color(h.mainColor),
                                                      width: 1.0),
                                                  color: Colors.white),
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.remove,
                                                size: 14,
                                                color: Color(h.mainColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .005,
                        ),
                        if (widget.c.offerPrice != 0.0)
                          Container(
                            width: MediaQuery.of(context).size.width * .5,
                            // child: Text(
                            //   '',
                            //   // "العروض المختاره : ${widget.c.offerName.substring(0, widget.c.offerName.length - 2) + "\t" + "=" "\t" + widget.c.offerPrice.toString() + "\t" + "ريال"} ",
                            //   style: TextStyle(
                            //     height: 1.0,
                            //     fontSize: 12,
                            //     color: Colors.black38,
                            //   ),
                            // ),
                          ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          "${DemoLocalizations.of(context).title['TotalPrice']} : ${widget.c.price2 * quantity ?? 0 + widget.c.totalPrice}" +
                              DemoLocalizations.of(context).title['currency'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          if (widget.c.subItems.isNotEmpty)
            Divider(
              color: Color(h.mainColor),
              endIndent: 20,
              indent: 20,
            ),
          if (widget.c.subItems.isNotEmpty)
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 5)
              // mainAxisExtent: 0.1
            ),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                SubItemWidget(widget.c.subItems[index]),
            itemCount: widget.c.subItems.length,
          ),
        ],
      ),
    );
  }

  DeleteFromCart(BuildContext context, id, int quantity, double totalPrice) {
    print(quantity.toString());
    print(totalPrice);
    print("000000000000000");
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 150.0,
          decoration: BoxDecoration(
            //border: Border.all(color: Colors.black12,width: 2.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "images/icon/about.png",
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        DemoLocalizations.of(context)
                            .title['Doyouwanttodeletetheitemfromcart'],
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(h.blueColor)),
                            height: MediaQuery.of(context).size.height * .045,
                            width: MediaQuery.of(context).size.width * .33,
                            alignment: Alignment.center,
                            child: Text(
                              DemoLocalizations.of(context).title['cancel'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(h.mainColor)),
                            height: MediaQuery.of(context).size.height * .045,
                            width: MediaQuery.of(context).size.width * .33,
                            alignment: Alignment.center,
                            child: Text(
                              DemoLocalizations.of(context).title['confirm'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          onTap: () async {
                            loadData();
                            setState(() {
                              db.delete(id);
                            });
                            // TODO handling action after delet from cart

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (_) => HomePage(
                                          index: 2,
                                        )),
                                (Route<dynamic> route) => false);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  loadData() async {
    dataLocal = await db.allProduct();
    setState(() {});
  }
}
