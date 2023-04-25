import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:mishwar/Model/CancelOrder.dart';
import 'package:mishwar/Model/HomeDeliveryOrderModel.dart';
import 'package:mishwar/Model/OrderDeliveryModel.dart';
import 'package:mishwar/Model/OrderDetailUpdate.dart';

import 'package:mishwar/Model/OrderStatusModel.dart';
import '../../Model/OrderDetails.dart';
import '../../Model/OrdersModel.dart';
import 'GlobalVariables.dart';

class OrderServices {
  String baseURL = GlobalVariables.URL;
  String Global_URL = GlobalVariables.url;

  // Future<Map<String, dynamic>> MakeOrder(var body) async {
  //   String url = baseURL + "/Order/Create";
  //   try {
  //     final responce = await http.post(
  //       Uri.parse(url),
  //       body: json.encode(body),
  //       headers: await getHeader(),
  //     );
  //     print(responce.body);
  //     print("000000000000000000000000000000000000000");
  //     if (responce.body.isNotEmpty) {
  //       print(responce.body);
  //       return json.decode(responce.body);
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<List<OrderDetails>> getOrderDetails(String orderId) async {
    try {
      final response = await http.get(Uri.parse(
          "${Global_URL}/Order/GetOrderDetailsByOrderId?orderId=$orderId"));

      print(response.body);

      if (response.statusCode == 200) {
        List listOfItems = jsonDecode(response.body);
        List<OrderDetails> l = [];
        listOfItems.forEach((element) {
          l.add(OrderDetails.fromJson(element));
        });
        // return listOfItems.map((e) {
        //   OrderDetails.fromJson(response.body);
        // }).toList();
        return l;
      }
    } catch (e) {
      print('$e,,,,error cancel order');
    }
  }

  Future<http.Response> MakeOrderUpdate(var body) async {
    EasyLoading.show();
    try {
      final responce = await http.post(
        Uri.parse('${Global_URL}/order/SaveOrder'),
        body: json.encode(body),
        headers: await getHeader(),
      );
      print(responce.body);
      print(responce.statusCode);
      print("000000000000000000000000000000000000000");

      if (responce.body.isNotEmpty) {
        print(responce.body);
        // return json.decode(responce.body);
        EasyLoading.dismiss();
        return responce;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<OrderStatusDetail>> GetOrderStatusUser() async {
    var url = "${GlobalVariables.URL}/Order/UserStatuses";
    print(url);
    try {
      final response =
          await http.post(Uri.parse(url), headers: await getHeader());
      print(response.body);
      print("00000000000000000000000000");
      if (response.statusCode == 200 && response.body != null) {
        List slideritems =
            json.decode(utf8.decode(response.bodyBytes))["Message"];
        return slideritems.map((e) => OrderStatusDetail.fromJson(e)).toList();
      }
    } catch (e) {
      print('$e,,,,error search doctors');
    }
  }

  // Future<List<OrderStatusDetail>> GetOrderStatusUser() async {
  //   var url = "${GlobalVariables.URL}/Order/UserStatuses";
  //   print(url);
  //   try {
  //     final response =
  //         await http.post(Uri.parse(url), headers: await getHeader());
  //     print(response.body);
  //     print("00000000000000000000000000");
  //     if (response.statusCode == 200 && response.body != null) {
  //       List slideritems =
  //           json.decode(utf8.decode(response.bodyBytes))["Message"];
  //       return slideritems.map((e) => OrderStatusDetail.fromJson(e)).toList();
  //     }
  //   } catch (e) {
  //     print('$e,,,,error search doctors');
  //   }
  // }

  Future<List<OrderStatusDetail>> GetOrderStatusDelevery() async {
    String url = "${GlobalVariables.URL}/delivery/statuses";
    print(url);
    print(await getHeader());
    try {
      final response =
          await http.post(Uri.parse(url), headers: await getHeader());
      print(response.body);
      print("00000000000000000000000000");
      if (response.statusCode == 200 && response.body != null) {
        List slideritems =
            json.decode(utf8.decode(response.bodyBytes))["Message"];
        print(
            "orders list : ${slideritems.map((e) => OrderStatusDetail.fromJson(e)).toList()}");
        return slideritems.map((e) => OrderStatusDetail.fromJson(e)).toList();
      }
    } catch (e) {
      print('$e,,,,error search doctors');
    }
  }

  Future<List<OrdersList>> GetOrdersUpdate(
      String user_id, String status_id) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$Global_URL/Order/GetOrdersByStatus?userid=$user_id&statusid=$status_id'),
        headers: await getHeader(),
      );

      if (response.statusCode == 200 && response.body != null) {
        List slideritems = json.decode(response.body);

        return slideritems.map((e) => OrdersList.fromJson(e)).toList();
      }
    } catch (e) {
      print('$e,,,,error search doctors');
    }
  }

  Future<OrderDetailNew> GetOrdersDetailsUpdate(String order_Id) async {
    try {
      final response = await http.get(
        Uri.parse('$Global_URL/Order/GetOrderProducts?orderId=31584'),
        headers: await getHeader(),
      );

      if (response.statusCode == 200 && response.body != null) {
        print(response.body);

        var Response = OrderDetailNew.fromJson(jsonDecode(response.body));
        List slideritems = json.decode(response.body)["List"];

        return Response;
      }
    } catch (e) {
      print('$e,,,,error search doctors');
    }
  }

  Future<OrderCancel> cancelOrder(int orderId) async {
    try {
      final response = await http.get(
        Uri.parse('$Global_URL/Order/CancellOrderByOrderId?orderId=$orderId'),
        headers: await getHeader(),
      );
      if (response.statusCode == 200) {
        print(response.body);
        var Response = OrderCancel.fromJson(jsonDecode(response.body));

        return Response;
      }
    } catch (e) {
      print('$e,,,,error cancel order');
    }
  }

  Future<List<DeliveryOrderDetail>> GetOrdersDelivery(
      var user_id, var status_id) async {
    var url = "${GlobalVariables.URL}/delivery/All?page=1";
    print(url);
    var body = {"driver_id": user_id, "status_id": status_id};
    print(body);
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(body), headers: await getHeader());
      print(response.body);
      if (response.statusCode == 200 && response.body != null) {
        List slideritems =
            json.decode(utf8.decode(response.bodyBytes))["Message"];
        return slideritems.map((e) => DeliveryOrderDetail.fromJson(e)).toList();
      }
    } catch (e) {
      print('$e,,,,error search doctors');
    }
  }

  Future<List<HomeDeliveryOrderDetail>> GetDeliveryHome(var user_id) async {
    var url = "${GlobalVariables.URL}/delivery/Home";
    print(url);
    var body = {"driver_id": user_id};
    print('${body},,,,,,,,,,,,body main driver');
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(body), headers: await getHeader());
      print(response.body);
      print("responceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      if (response.statusCode == 200 && response.body != null) {
        List slideritems =
            json.decode(utf8.decode(response.bodyBytes))["Message"];
        return slideritems
            .map((e) => HomeDeliveryOrderDetail.fromJson(e))
            .toList();
      }
    } catch (e) {
      print('$e,,,,error search doctors');
    }
  }

  Future<Map<String, dynamic>> EndOrder(var driver_id, var order_id) async {
    String url = baseURL + "/delivery/EndDelivery";
    print(url);
    var body = {"driver_id": driver_id, "order_id": order_id};
    print(body);
    print("000000000000000000000000000000000000000000000000000000000000000");
    try {
      final responce = await http.post(Uri.parse(url),
          body: json.encode(body), headers: await getHeader());
      print(responce.body);
      print("000000000000000000000000000000000000000");
      if (responce.body.isNotEmpty) {
        print(responce.body);
        return json.decode(responce.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Map<String, dynamic>> StartOrder(var driver_id, var order_id) async {
    String url = baseURL + "/delivery/StartDelivery";
    var body = {"driver_id": driver_id, "order_id": order_id};
    try {
      final responce = await http.post(Uri.parse(url),
          body: json.encode(body), headers: await getHeader());
      print(responce.body);
      print("000000000000000000000000000000000000000");
      if (responce.body.isNotEmpty) {
        print(responce.body);
        return json.decode(responce.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Map<String, dynamic>> CancelOrder(
      var driver_id, var order_id, var cancel_reason) async {
    String url = baseURL + "/delivery/CancelDelivery";
    print(url);
    var body = {
      "driver_id": driver_id,
      "order_id": order_id,
      "cancel_reason": "Aaaaaaa"
    };
    print(body);

    try {
      final responce = await http.post(Uri.parse(url),
          body: json.encode(body), headers: await getHeader());
      print(responce.body);
      print("000000000000000000000000000000000000000");
      if (responce.body.isNotEmpty) {
        print(responce.body);
        return json.decode(responce.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Map<String, dynamic>> CancelDeliveryAfterConfirm(
      var driver_id, var order_id, var cancel_reason) async {
    String url = baseURL + "/delivery/CancelDeliveryAfterConfirm";
    print(url);
    var body = {
      "driver_id": driver_id,
      "order_id": order_id,
      "cancel_reason": "Aaaaaaa"
    };
    print(body);

    try {
      final responce = await http.post(Uri.parse(url),
          body: json.encode(body), headers: await getHeader());
      print(responce.body);
      print("000000000000000000000000000000000000000");
      if (responce.body.isNotEmpty) {
        print(responce.body);
        return json.decode(responce.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

/*
Future<List<OrderDetailModel>> GetOrders(var user_id, var status_id) async {
  var url = "${GlobalVariables.URL}/Order/All?page=1";
  print(url);

  var body = {"user_id": user_id, "status_id": status_id};

  print("444=$user_id");
  print("555=$status_id");
  print(body);
  try {
    final response = await http.post(Uri.parse(url),
        body: json.encode(body), headers: await getHeader());
    print(response.body);
    if (response.statusCode == 200 && response.body != null) {
      List slideritems =
      json.decode(utf8.decode(response.bodyBytes))["Message"];
      return slideritems.map((e) => OrderDetailModel.fromJson(e)).toList();
    }
  } catch (e) {
    print('$e,,,,error search doctors');
  }
}
*/
