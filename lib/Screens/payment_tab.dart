import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_tap_payment/flutter_tap_payment.dart';
import 'package:mishwar/Model/user.dart';
import 'package:mishwar/Screens/services/toast_service.dart';
import 'package:mishwar/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/Services/OrderServices.dart';
import '../dbHelper.dart';
import 'OrderSucess.dart';

class PaymentTab extends StatefulWidget {
  double totalAmount;
  dynamic body;
  String userID;
  String branchID;
  int totalQuantity;
  int orderNumber;
  double subtotal;
  double total;
  double tax;
  double deliveryCost;

  PaymentTab(
    this.totalAmount,
    this.body,
    this.userID,
    this.branchID,
    this.totalQuantity,
    this.orderNumber,
    this.subtotal,
    this.total,
    this.tax,
    this.deliveryCost,
  );

  static String getPaymentStatus(String messge) {
    return messge;
  }

  @override
  State<PaymentTab> createState() => _PaymentTabState();
}

class _PaymentTabState extends State<PaymentTab> {
  User user = User();

  OrderServices orderServvices = new OrderServices();
  DbHelper db = new DbHelper();
  int orderNumber;

  onSuccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await orderServvices.MakeOrderUpdate(
      widget.body,
    );

    if (response.statusCode == 200) {
      print(response);
      orderNumber = json.decode(response.body)["item1"];
      db.deleteCart();
      prefs.remove("address_id");
    }
  }

  @override
  Widget build(BuildContext context) {
    return TapPayment(
      apiKey: "sk_live_HrvSqZC6L09Pn42tsj5zuIyR",
      redirectUrl: "https://tap.company",
      postUrl: "https://tap.company",
      // redirectUrl: "http://your_website.com/redirect_url",
      // postUrl: "http://your_website.com/post_url",
      paymentData: {
        "amount": widget.totalAmount,
        "currency": "SAR",
        "threeDSecure": true,
        "save_card": false,
        "description": "Live Description",
        "statement_descriptor": "Sample",
        "metadata": {"udf1": "test 1", "udf2": "test 2"},
        "reference": {"transaction": "txn_0001", "order": "ord_0001"},
        "receipt": {"email": true, "sms": true},
        "customer": {
          "first_name": home.username,
          "middle_name": "",
          "last_name": "",
          "email": home.email,
          "phone": {"country_code": "965", "number": home.phone}
        },
        // "merchant": {"id": ""},
        "source": {"id": "src_card"},
        // "destinations": {
        //   "destination": [
        //     {"id": "480593777", "amount": 2, "currency": "KWD"},
        //     {"id": "486374777", "amount": 3, "currency": "KWD"}
        //   ]
        // }
      },
      onSuccess: (Map params) {
        onSuccess();

        /*SharedPreferences prefs =
        await SharedPreferences.getInstance();

        print("onSuccess: ${params["message"]}");
        PaymentTab.PaymentTab.getPaymentStatus(params["message"]);

        Map<String, dynamic> data =
        await orderServvices.MakeOrderUpdate(
          widget.body,
          prefs.getString("UserId"),
          Provider.of<GetUserBranch>(context, listen: false).branchId,
        );

        if (data["statusCode"] == 200) {
          print(data);
          orderNumber = data["key"];
          db.deleteCart();
          prefs.remove("address_id");
        }*/

      },
      onError: (error) {
        // Navigator.of(context).pop();
        ToastService.showErrorToast(error["response"]["message"]);
        print("onError: $error");
      },
      widget: OrderSuccess(widget.totalQuantity, widget.orderNumber,
          widget.subtotal, widget.total, widget.tax, widget.deliveryCost),
    );
  }
}
