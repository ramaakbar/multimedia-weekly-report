// To parse this JSON data, do
//
//     final reportCrewModel = reportCrewModelFromJson(jsonString);

import 'dart:convert';

ReportCrewModel reportCrewModelFromJson(String str) =>
    ReportCrewModel.fromJson(json.decode(str));

String reportCrewModelToJson(ReportCrewModel data) =>
    json.encode(data.toJson());

class ReportCrewModel {
  ReportCrewModel({
    required this.status,
    required this.data,
  });

  Status status;
  List<Datum> data;

  factory ReportCrewModel.fromJson(Map<String, dynamic> json) =>
      ReportCrewModel(
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
    required this.assigned,
    required this.name,
    required this.count,
  });

  String assigned;
  String name;
  String count;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        assigned: json["assigned"],
        name: json["name"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "assigned": assigned,
        "name": name,
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
