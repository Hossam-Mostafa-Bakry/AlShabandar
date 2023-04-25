import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:mishwar/main.dart';

import '../Model/OrderDetails.dart';
import '../Model/OrdersModel.dart';

class OrderItem extends StatelessWidget {
  final OrderDetails orderDetail;
  final String orderDate;


  OrderItem({Key key, this.orderDetail, this.orderDate = ""}) : super(key: key);
  final home h = new home();
  String offerprice = '';


  @override
  Widget build(BuildContext context) {
    // if (orderDetail.notes.length > 20) {
    //   offerprice = orderDetail.notes.substring(
    //       orderDetail.notes.length - 10,
    //       orderDetail.notes.length - 5);
    // } else {
    //   offerprice = '';
    // }

    DateTime date = DateTime.parse(orderDate);
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .005,
        bottom: MediaQuery.of(context).size.height * .005,
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
              Container(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      width: MediaQuery.of(context).size.width * .25,
                      height: orderDetail.notes.toString().isEmpty ||
                              orderDetail.notes == null
                          ? MediaQuery.of(context).size.height * .12
                          : MediaQuery.of(context).size.height * .15,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        child: orderDetail.image == null
                            ? Image.asset(
                                'images/prodcut4.png',
                                width: MediaQuery.of(context).size.width * .9,
                                height:
                                    MediaQuery.of(context).size.height * .08,
                                fit: BoxFit.cover,
                              )
                            : FadeInImage.assetNetwork(
                                placeholder: "images/prodcut4.png",
                                image: orderDetail.image,
                                width: MediaQuery.of(context).size.width * .9,
                                height:
                                    MediaQuery.of(context).size.height * .08,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: orderDetail.notes.toString().isEmpty ||
                          orderDetail.notes == null
                          ? MediaQuery.of(context).size.height * .12
                          : MediaQuery.of(context).size.height * .15,
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .008,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .61,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  orderDetail.itemName ?? "",
                                  style: TextStyle(
                                      height: 1.0,
                                      fontSize: 14,
                                      color: Color(h.mainColor)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .61,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DemoLocalizations.of(context).title['qunt'] +
                                      " : ${orderDetail.quantity} ",
                                  // "${double.parse(orderDetail.details.salePrice) * double.parse(orderDetail.details.quantity)}" +

                                  style: TextStyle(
                                      color: Colors.black, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .61,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DemoLocalizations.of(context).title['price'] +
                                      " : ${orderDetail.totalValue} " +
                                      // "${double.parse(orderDetail.details.salePrice) * double.parse(orderDetail.details.quantity)}" +
                                      DemoLocalizations.of(context)
                                          .title['currency'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            DemoLocalizations.of(context).title['ordertime'] +
                                ' :  ${DateFormat('yyyy-MM-dd    h:mm a').format(date)}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                            ),
                          ),
                          orderDetail.notes.toString().isEmpty ||
                                  orderDetail.notes == null
                              ? Container(height: 0)
                              : Text(
                                  orderDetail.notes.toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 11),
                                ),
                          if (offerprice != '') Text(
                              // '',
                              'الاجمالي = ${(double.parse(offerprice) + (double.parse(orderDetail.totalValue.toString()) * double.parse(orderDetail.quantity.toString()))).toStringAsFixed(2)} ريال'),
                          // 'الاجمالي = ${(double.parse(offerprice) + (double.parse(orderDetail.details.salePrice) * double.parse(orderDetail.details.quantity))).toStringAsFixed(2)} ريال')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
