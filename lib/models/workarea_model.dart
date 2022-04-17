// To parse this JSON data, do
//
//     final workAreaModel = workAreaModelFromJson(jsonString);

import 'dart:convert';

WorkAreaModel workAreaModelFromJson(String str) =>
    WorkAreaModel.fromJson(json.decode(str));

String workAreaModelToJson(WorkAreaModel data) => json.encode(data.toJson());

class WorkAreaModel {
  WorkAreaModel({
    this.status,
    this.data,
  });

  Status? status;
  List<Datum>? data;

  factory WorkAreaModel.fromJson(Map<String, dynamic> json) => WorkAreaModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status!.toJson(),
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.workCode,
    required this.workArea,
  });

  String workCode;
  String workArea;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        workCode: json["work_code"] == null ? null : json["work_code"],
        workArea: json["work_area"] == null ? null : json["work_area"],
      );

  Map<String, dynamic> toJson() => {
        "work_code": workCode == null ? null : workCode,
        "work_area": workArea == null ? null : workArea,
      };
}

class Status {
  Status({
    this.message,
    this.code,
  });

  String? message;
  int? code;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        message: json["message"] == null ? null : json["message"],
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "code": code == null ? null : code,
      };
}
