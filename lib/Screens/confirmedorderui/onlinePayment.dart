import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:hyperpay/hyperpay.dart';
import 'package:mishwar/Screens/confirmedorderui/paymentProvider.dart';
import 'package:provider/provider.dart';

import 'formatters.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({
    Key key,
  }) : super(key: key);

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  TextEditingController holderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  // BrandType brandType = BrandType.none;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isLoading = false;
  // PayMentProvider payMentProvider;

  @override
  void initState() {
    // payMentProvider = Provider.of<PayMentProvider>(context, listen: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      // child: Scaffold(
      //   backgroundColor: Colors.grey.shade100,
      //   appBar: AppBar(
      //     // title: const Text(
      //     //   "Checkout",
      //     //   style: TextStyle(
      //     //     color: Colors.black,
      //     //   ),
      //     // ),
      //     iconTheme: IconThemeData(
      //       color: Colors.black
      //     ),
      //     elevation: 0,
      //     // leading: Icon(Icons.arrow_back_ios),
      //     backgroundColor: Colors.transparent,
      //   ),
      //   body: SingleChildScrollView(
      //     child: Container(
      //       alignment: Alignment.center,
      //       padding: const EdgeInsets.all(20.0),
      //       margin: const EdgeInsets.all(20.0),
      //       decoration: BoxDecoration(color: Colors.white),
      //       child: Form(
      //         autovalidateMode: autovalidateMode,
      //         child: Builder(
      //           builder: (context) {
      //             return Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   'CheckOut',
      //                   style: TextStyle(
      //                     color: Colors.black87,
      //                     fontSize: 26,
      //                   ),
      //                 ),
      //                 const SizedBox(height: 30),
      //                 // Holder
      //                 Text(
      //                   'Name On Card',
      //                   textDirection: TextDirection.ltr,
      //                   style: TextStyle(
      //                     color: Colors.black54
      //                   ),
      //                 ),
      //                 const SizedBox(height: 5),
      //                 TextFormField(
      //                   controller: holderNameController,
      //                   decoration: _inputDecoration(
      //                     // label: "Card Holder",
      //                     hint: "Jane Jones",
      //                     icon: Icons.account_circle_rounded,
      //                   ),
      //                 ),
      //                 const SizedBox(height: 15),
      //                 // Number
      //                 Text(
      //                   'Card Namber',
      //                   textDirection: TextDirection.ltr,
      //                   style: TextStyle(
      //                       color: Colors.black54
      //                   ),
      //                 ),
      //                 const SizedBox(height: 5),
      //                 TextFormField(
      //                   controller: cardNumberController,
      //                   decoration: _inputDecoration(
      //                     // label: "Card Number",
      //                     hint: "0000 0000 0000 0000",
      //                     icon: brandType == BrandType.none
      //                         ? Icons.credit_card
      //                         : 'images/${brandType.asString}.png',
      //                   ),
      //                   onChanged: (value) {
      //                     setState(() {
      //                       brandType = value.detectBrand;
      //                     });
      //                   },
      //                   inputFormatters: [
      //                     FilteringTextInputFormatter.digitsOnly,
      //                     LengthLimitingTextInputFormatter(brandType.maxLength),
      //                     CardNumberInputFormatter()
      //                   ],
      //                   validator: (String number) =>
      //                       brandType.validateNumber(number ?? ""),
      //                 ),
      //                 const SizedBox(height: 12),
      //                 // Number
      //                 Row(
      //                   children: [
      //                     Expanded(
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Text(
      //                             'Expiry Data',
      //                             textDirection: TextDirection.ltr,
      //                             style: TextStyle(
      //                                 color: Colors.black54
      //                             ),
      //                           ),
      //                           const SizedBox(height: 5),
      //                           // Expiry date
      //                           TextFormField(
      //                             controller: expiryController,
      //                             decoration: _inputDecoration(
      //                               // label: "Expiry Date",
      //                               hint: "MM/YY",
      //                               icon: Icons.date_range_rounded,
      //                             ),
      //                             inputFormatters: [
      //                               FilteringTextInputFormatter.digitsOnly,
      //                               LengthLimitingTextInputFormatter(4),
      //                               CardMonthInputFormatter(),
      //                             ],
      //                             validator: (String date) =>
      //                                 CardInfo.validateDate(date ?? ""),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                     const SizedBox(width: 15),
      //                     Expanded(
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Text(
      //                             'CVV',
      //                             textDirection: TextDirection.ltr,
      //                             style: TextStyle(
      //                                 color: Colors.black54
      //                             ),
      //                           ),
      //                           const SizedBox(height: 5),
      //                           // CVV
      //                           TextFormField(
      //                             controller: cvvController,
      //                             decoration: _inputDecoration(
      //                               // label: "CVV",
      //                               hint: "000",
      //                               icon: Icons.confirmation_number_rounded,
      //                             ),
      //                             inputFormatters: [
      //                               FilteringTextInputFormatter.digitsOnly,
      //                               LengthLimitingTextInputFormatter(4),
      //                             ],
      //                             validator: (String cvv) =>
      //                                 CardInfo.validateCVV(cvv ?? ""),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 const SizedBox(height: 45),
      //                 SizedBox(
      //                   width: double.infinity,
      //                   child: ElevatedButton(
      //                     style: ButtonStyle(
      //
      //                       backgroundColor: MaterialStateProperty.all(Color(0xffD4252F)),
      //                     ),
      //                     onPressed: isLoading
      //                         ? null
      //                         : () async {
      //                             final bool valid =
      //                                 Form.of(context)?.validate() ?? false;
      //                             if (valid) {
      //                               setState(() {
      //                                 isLoading = true;
      //                               });
      //
      //                               // Make a CardInfo from the controllers
      //                               CardInfo card = CardInfo(
      //                                 holder: holderNameController.text,
      //                                 cardNumber: cardNumberController.text
      //                                     .replaceAll(' ', ''),
      //                                 cvv: cvvController.text,
      //                                 expiryMonth:
      //                                     expiryController.text.split('/')[0],
      //                                 expiryYear: '20' +
      //                                     expiryController.text.split('/')[1],
      //                               );
      //
      //                               try {
      //                                 // Start transaction
      //                                 if (payMentProvider
      //                                     .sessionCheckoutID.isEmpty) {
      //                                   // Only get a new checkoutID if there is no previous session pending now
      //                                   await payMentProvider
      //                                       .initPaymentSession(brandType, 50);
      //                                 }
      //
      //                                 final result = await payMentProvider
      //                                     .hyperpay
      //                                     .pay(card);
      //
      //                                 switch (result) {
      //                                   case PaymentStatus.init:
      //                                     ScaffoldMessenger.of(context)
      //                                         .showSnackBar(
      //                                       const SnackBar(
      //                                         content: Text(
      //                                             'Payment session is still in progress'),
      //                                         backgroundColor: Colors.amber,
      //                                       ),
      //                                     );
      //                                     break;
      //                                   // For the sake of the example, the 2 cases are shown explicitly
      //                                   // but in real world it's better to merge pending with successful
      //                                   // and delegate the job from there to the server, using webhooks
      //                                   // to get notified about the final status and do some action.
      //                                   case PaymentStatus.pending:
      //                                     ScaffoldMessenger.of(context)
      //                                         .showSnackBar(
      //                                       const SnackBar(
      //                                         content:
      //                                             Text('Payment pending ⏳'),
      //                                         backgroundColor: Colors.amber,
      //                                       ),
      //                                     );
      //                                     break;
      //                                   case PaymentStatus.successful:
      //                                     payMentProvider.sessionCheckoutID =
      //                                         '';
      //                                     ScaffoldMessenger.of(context)
      //                                         .showSnackBar(
      //                                       const SnackBar(
      //                                         content:
      //                                             Text('Payment approved 🎉'),
      //                                         backgroundColor: Colors.green,
      //                                       ),
      //                                     );
      //                                     break;
      //
      //                                   default:
      //                                 }
      //                               } on HyperpayException catch (exception) {
      //                                 payMentProvider.sessionCheckoutID = '';
      //                                 ScaffoldMessenger.of(context)
      //                                     .showSnackBar(
      //                                   SnackBar(
      //                                     content: Text(exception.details ??
      //                                         exception.message),
      //                                     backgroundColor: Colors.red,
      //                                   ),
      //                                 );
      //                               } catch (exception) {
      //                                 ScaffoldMessenger.of(context)
      //                                     .showSnackBar(
      //                                   SnackBar(
      //                                     content: Text('$exception'),
      //                                   ),
      //                                 );
      //                               }
      //
      //                               setState(() {
      //                                 isLoading = false;
      //                               });
      //                             } else {
      //                               setState(() {
      //                                 autovalidateMode =
      //                                     AutovalidateMode.onUserInteraction;
      //                               });
      //                             }
      //                           },
      //                     child: Text(
      //                       isLoading
      //                           ? 'Processing your request, please wait...'
      //                           : 'PAY',
      //                     ),
      //                   ),
      //                 )
      //               ],
      //             );
      //           },
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  InputDecoration _inputDecoration({String label, String hint, dynamic icon}) {
    return InputDecoration(
      hintStyle: TextStyle(
        fontSize: 14,
        color: Colors.black45
      ),
      hintText: hint,
      labelText: label,
      filled: true,
      enabled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
       contentPadding: EdgeInsets.all(8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: BorderSide.none,
      ),
      fillColor: Colors.grey.shade200,
      prefixIcon: icon is IconData
          ? Icon(icon)
          : Container(
              padding: const EdgeInsets.all(6),
              width: 10,
              child: Image.asset(icon),
            ),
    );
  }
}
