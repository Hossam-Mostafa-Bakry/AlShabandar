// import 'package:flutter/material.dart';
// import 'package:hyperpay/hyperpay.dart';
// import 'constants.dart';
// import 'networkUtlis.dart';
//
// class PayMentProvider with ChangeNotifier {
//
//   NetworkUtil utils = NetworkUtil();
//   HyperpayPlugin hyperpay;
//   String sessionCheckoutID = '';
//   Future<void> initPaymentSession(
//     BrandType brandType,
//     double amount,
//   ) async {
//     hyperpay = await HyperpayPlugin.setup(config: TestConfig());
//     CheckoutSettings _checkoutSettings = CheckoutSettings(
//       brand: brandType,
//       amount: amount,
//       headers: {
//         // "Content-Type": "application/json",
//         // "X-Auth-Token": "dfbed9f22f0f2263ee0ffc5484a42a43"
//       },
//       additionalParams: {
//         'merchantTransactionId': '#123456',
//       },
//     );
//
//     hyperpay.initSession(checkoutSetting: _checkoutSettings);
//     sessionCheckoutID = await hyperpay.getCheckoutID;
//   }
// }
