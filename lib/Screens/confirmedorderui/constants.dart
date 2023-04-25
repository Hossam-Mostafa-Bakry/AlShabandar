// import 'package:hyperpay/hyperpay.dart';
//
// class TestConfig implements HyperpayConfig {
//   @override
//   String creditcardEntityID = '8ac7a4c77b1ac40a017b259e7dc51661';
//   @override
//   String madaEntityID = '8ac7a4c77b1ac40a017b259fa4be1666';
//   @override
//   Uri checkoutEndpoint = _checkoutEndpoint;
//   @override
//   Uri statusEndpoint = _statusEndpoint;
//   @override
//   PaymentMode paymentMode = PaymentMode.test;
// }
//
// class LiveConfig implements HyperpayConfig {
//   @override
//   String creditcardEntityID = '8ac7a4c77b1ac40a017b259e7dc51661';
//   @override
//   String madaEntityID = '8ac7a4c77b1ac40a017b259fa4be1666';
//   @override
//   Uri checkoutEndpoint = _checkoutEndpoint;
//   @override
//   Uri statusEndpoint = _statusEndpoint;
//   @override
//   PaymentMode paymentMode = PaymentMode.live;
// }
//
// // Setup using your own endpoints.
// // https://wordpresshyperpay.docs.oppwa.com/tutorials/mobile-sdk/integration/server.
//
// String _host = "dev.hyperpay.com";
//
// Uri _checkoutEndpoint = Uri(
//   scheme: 'http',
//   host: _host,
//   path: 'hyperpay-demo/getcheckoutid.php',
// );
//
// Uri _statusEndpoint = Uri(
//   scheme: 'http',
//   host: _host,
//   path: 'hyperpay-demo/getpaymentstatus.php',
// );
