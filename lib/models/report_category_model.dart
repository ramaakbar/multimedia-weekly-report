// To parse this JSON data, do
//
//     final reportCategoryModel = reportCategoryModelFromJson(jsonString);

import 'dart:convert';

ReportCategoryModel reportCategoryModelFromJson(String str) =>
    ReportCategoryModel.fromJson(json.decode(str));

String reportCategoryModelToJson(ReportCategoryModel data) =>
    json.encode(data.toJson());

class ReportCategoryModel {
  ReportCategoryModel({
    required this.status,
    required this.data,
  });

  Status status;
  List<Datum> data;

  factory ReportCategoryModel.fromJson(Map<String, dynamic> json) =>
      ReportCategoryModel(
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
    required this.workArea,
    required this.count,
  });

  String workArea;
  String count;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        workArea: json["work_area"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "work_area": workArea,
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
