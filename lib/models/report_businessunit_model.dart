// To parse this JSON data, do
//
//     final reportBusinessunitModel = reportBusinessunitModelFromJson(jsonString);

import 'dart:convert';

ReportBusinessunitModel reportBusinessunitModelFromJson(String str) =>
    ReportBusinessunitModel.fromJson(json.decode(str));

String reportBusinessunitModelToJson(ReportBusinessunitModel data) =>
    json.encode(data.toJson());

class ReportBusinessunitModel {
  ReportBusinessunitModel({
    required this.status,
    required this.data,
  });

  Status status;
  List<Datum> data;

  factory ReportBusinessunitModel.fromJson(Map<String, dynamic> json) =>
      ReportBusinessunitModel(
        status: Status.fromJson(json["status"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.businessUnit,
    required this.count,
  });

  String businessUnit;
  String count;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        businessUnit: json["business_unit"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "business_unit": businessUnit,
        "count": count,
      };
}

class Status {
  Status({
    required this.message,
    required this.code,
  });

  String message;
  int code;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
      };
}
