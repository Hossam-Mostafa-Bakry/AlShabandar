import 'package:flutter/material.dart';
import 'package:mishwar/Model/CartModelLocal.dart';
import 'package:mishwar/Screens/sub_item_widget.dart';
import 'package:mishwar/lang/app_Localization.dart';

import '../Model/cart_model.dart';
import '../main.dart';

class CartOrderItem extends StatelessWidget {
  final CartModel c;

  CartOrderItem({Key key, this.c}) : super(key: key);
  final home h = new home();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(),
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .008,
          bottom: MediaQuery.of(context).size.height * .008,
          left: MediaQuery.of(context).size.width * .05,
          right: MediaQuery.of(context).size.width * .05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          width: 1.0,
          color: Colors.black12.withOpacity(.05),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    //  top: MediaQuery.of(context).size.height*.003
                    ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      width: MediaQuery.of(context).size.width * .25,
                      height: MediaQuery.of(context).size.height * .08,
                      margin: EdgeInsets.only(),
                      child: ClipRRect(
                        borderRadius:
                            DemoLocalizations.of(context).locale == Locale("ar")
                                ? BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )
                                : BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  ),
                        child: c.img == null
                            ? Image.asset("images/no-img.jpg", fit: BoxFit.cover)
                            : FadeInImage.assetNetwork(
                                placeholder: "images/prodcut4.png",
                                image: c.img == null ? "" : c.img,
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
                      height: MediaQuery.of(context).size.height * .08,
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
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .61,
                                  child: Text(
                                    c.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      height: 1.0,
                                      fontSize: 14,
                                      color: Color(h.mainColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .00,
                          ),
                          if (c.offerPrice != 0.0 && c.offerName != null)
                            Container(
                              width: MediaQuery.of(context).size.width * .5,
                              child: Text(
                                "العروض المختاره : ${c.offerName.substring(0, c.offerName.length - 2) + "\t" + "=" "\t" + c.offerPrice.toString() + "\t" + "ريال"} ",
                                style: TextStyle(
                                    height: 1.0,
                                    fontSize: 10,
                                    color: Colors.black38),
                              ),
                            ),
                          Container(
                            width: MediaQuery.of(context).size.width * .61,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${DemoLocalizations.of(context).title['TotalPrice']} :  ${c.totalPrice} " +
                                      DemoLocalizations.of(context)
                                          .title['currency'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .008,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          if (c.subItems.isNotEmpty)
            Divider(
              color: Color(h.mainColor),
              endIndent: 20,
              indent: 20,
            ),
          if (c.subItems.isNotEmpty)
          // ListView.builder(
          //   shrinkWrap: true,
          //   itemBuilder: (context, index) =>
          //       SubItemWidget(widget.c.subItems[index]),
          //   itemCount: widget.c.subItems.length,
          // ),
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
                  SubItemWidget(c.subItems[index]),
              itemCount: c.subItems.length,
            ),
        ],
      ),
    );
  }
}
