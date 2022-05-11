// To parse this JSON data, do
//
//     final ArchiveModel = ArchiveModelFromJson(jsonString);

import 'dart:convert';

ArchiveModel weeklyModelFromJson(String str) =>
    ArchiveModel.fromJson(json.decode(str));

String weeklyModelToJson(ArchiveModel data) => json.encode(data.toJson());

class ArchiveModel {
  ArchiveModel({
    this.status,
    this.data,
  });

  Status? status;
  List<Datum>? data;

  factory ArchiveModel.fromJson(Map<String, dynamic> json) => ArchiveModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status?.toJson(),
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.workArea,
    this.woNumber,
    this.projectName,
    this.progress,
    this.assigned,
    this.name,
  });

  String? workArea;
  String? woNumber;
  String? projectName;
  String? progress;
  String? assigned;
  String? name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        workArea: json["work_area"] == null ? null : json["work_area"],
        woNumber: json["wo_number"] == null ? null : json["wo_number"],
        projectName: json["project_name"] == null ? null : json["project_name"],
        progress: json["progress"] == null ? null : json["progress"],
        assigned: json["assigned"] == null ? null : json["assigned"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "work_area": workArea == null ? null : workArea,
        "wo_number": woNumber == null ? null : woNumber,
        "project_name": projectName == null ? null : projectName,
        "progress": progress == null ? null : progress,
        "assigned": assigned == null ? null : assigned,
        "name": name == null ? null : name,
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
