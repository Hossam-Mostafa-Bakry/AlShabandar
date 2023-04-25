import 'package:meta/meta.dart';

class PaymentModel {
  PaymentModel({
    @required this.statusCode,
    @required this.api,
  });

  final int statusCode;
  final Api api;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        statusCode: json["StatusCode"] == null ? null : json["StatusCode"],
        api: json["API"] == null ? null : Api.fromJson(json["API"]),
      );
}

class Api {
  Api({
    @required this.result,
    @required this.buildNumber,
    @required this.timestamp,
    @required this.ndc,
    @required this.id,
  });

  final Result result;
  final String buildNumber;
  final String timestamp;
  final String ndc;
  final String id;

  factory Api.fromJson(Map<String, dynamic> json) => Api(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        buildNumber: json["buildNumber"] == null ? null : json["buildNumber"],
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
        ndc: json["ndc"] == null ? null : json["ndc"],
        id: json["id"] == null ? null : json["id"],
      );
}

class Result {
  Result({
    @required this.code,
    @required this.description,
  });

  final String code;
  final String description;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        code: json["code"] == null ? null : json["code"],
        description: json["description"] == null ? null : json["description"],
      );
}
