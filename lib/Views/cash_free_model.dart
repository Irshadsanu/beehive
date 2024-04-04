// To parse this JSON data, do
//
//     final cashfreemodel = cashfreemodelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Cashfreemodel cashfreemodelFromJson(String str) => Cashfreemodel.fromJson(json.decode(str));

String cashfreemodelToJson(Cashfreemodel data) => json.encode(data.toJson());

class Cashfreemodel {
  Cashfreemodel({
    required this.status,
    required this.message,
    required this.cftoken,
  });

  String status;
  String message;
  String cftoken;

  factory Cashfreemodel.fromJson(Map<String, dynamic> json) => Cashfreemodel(
    status: json["status"],
    message: json["message"],
    cftoken: json["cftoken"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "cftoken": cftoken,
  };
}
