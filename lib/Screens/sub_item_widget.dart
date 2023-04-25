import 'package:flutter/material.dart';

import '../Model/cart_model.dart';
import '../lang/app_Localization.dart';
import '../main.dart';

class SubItemWidget extends StatefulWidget {
  SubItem subItem;

  SubItemWidget(this.subItem);

  @override
  State<SubItemWidget> createState() => _SubItemWidgetState();
}

class _SubItemWidgetState extends State<SubItemWidget> {
  home h = new home();

  @override
  void initState() {
    print("${widget.subItem.subItemQuntity}...subItemQuntity ");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      width: MediaQuery.of(context).size.width * 0.45,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: widget.subItem.subItemImage == null
                ? Image.asset(
                    "images/no-img.jpg",
                    fit: BoxFit.cover,
                    height: 60,
                  )
                : FadeInImage.assetNetwork(
                    placeholder: "images/prodcut4.png",
                    image: widget.subItem.subItemImage == null
                        ? ""
                        : widget.subItem.subItemImage,
                    width: 70,
                    height: 70,
                    fit: BoxFit.fill,
                  ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.subItem.subItemName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.0,
                    fontSize: 12,
                    color: Color(h.mainColor),
                  ),
                ),
                Text(
                  widget.subItem.subItemQuntity.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                Text(
                  widget.subItem.subItemPrice2.toString() + " " +
                      DemoLocalizations.of(context).title['currency'],
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
