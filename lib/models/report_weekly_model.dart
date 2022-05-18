// To parse this JSON data, do
//
//     final reportWeeklyModel = reportWeeklyModelFromJson(jsonString);

import 'dart:convert';

ReportWeeklyModel reportWeeklyModelFromJson(String str) =>
    ReportWeeklyModel.fromJson(json.decode(str));

String reportWeeklyModelToJson(ReportWeeklyModel data) =>
    json.encode(data.toJson());

class ReportWeeklyModel {
  ReportWeeklyModel({
    required this.status,
    required this.data,
  });

  Status status;
  List<Datum> data;

  factory ReportWeeklyModel.fromJson(Map<String, dynamic> json) =>
      ReportWeeklyModel(
        status: Status.fromJson(json["status"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum(
      {this.businessUnit,
      this.projectName,
      this.progress,
      this.devAction,
      this.dateSubmit,
      this.name});

  String? businessUnit;
  String? projectName;
  String? progress;
  String? devAction;
  String? dateSubmit;
  String? name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        businessUnit:
            json["business_unit"] == null ? null : json["business_unit"],
        projectName: json["project_name"] == null ? null : json["project_name"],
        progress: json["progress"] == null ? null : json["progress"],
        devAction: json["dev_action"] == null ? null : json["dev_action"],
        dateSubmit: json["date_submit"] == null ? null : json["date_submit"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "business_unit": businessUnit,
        "project_name": projectName,
        "progress": progress,
        "dev_action": devAction,
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
