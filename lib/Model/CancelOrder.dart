/// StatusCode : 200
/// MessageCode : "Order Cancelled Successfully"
/// Key : 0

class OrderCancel {
  OrderCancel({
    this.statusCode,
    this.messageCode,
    this.key,
  });

  OrderCancel.fromJson(dynamic json) {
    statusCode = json['StatusCode'];
    messageCode = json['MessageCode'];
    key = json['Key'];
  }

  int statusCode;
  String messageCode;
  int key;

  OrderCancel copyWith({
    int statusCode,
    String messageCode,
    int key,
  }) =>
      OrderCancel(
        statusCode: statusCode ?? this.statusCode,
        messageCode: messageCode ?? this.messageCode,
        key: key ?? this.key,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = statusCode;
    map['MessageCode'] = messageCode;
    map['Key'] = key;
    return map;
  }
}
