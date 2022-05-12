// To parse this JSON data, do
//
//     final CrewReportModel = CrewReportModelFromJson(jsonString);

import 'dart:convert';

CrewReportModel weeklyModelFromJson(String str) =>
    CrewReportModel.fromJson(json.decode(str));

String weeklyModelToJson(CrewReportModel data) => json.encode(data.toJson());

class CrewReportModel {
  CrewReportModel({
    this.status,
    this.data,
  });

  Status? status;
  List<Datum>? data;

  factory CrewReportModel.fromJson(Map<String, dynamic> json) =>
      CrewReportModel(
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
    this.id,
    this.workArea,
    this.woNumber,
    this.projectName,
    this.activity,
    this.progress,
    this.dateSubmit,
    this.manHours,
    this.idPtfi,
    this.devAction,
    this.name,
    this.startDate,
    this.endDate,
    this.businessUnit,
    this.requestor,
  });
  String? id;
  String? workArea;
  String? woNumber;
  String? projectName;
  String? activity;
  String? progress;
  DateTime? dateSubmit;
  String? manHours;
  String? idPtfi;
  String? devAction;
  String? name;
  DateTime? startDate;
  DateTime? endDate;
  String? businessUnit;
  String? requestor;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        workArea: json["work_area"] == null ? null : json["work_area"],
        woNumber: json["wo_number"] == null ? null : json["wo_number"],
        projectName: json["project_name"] == null ? null : json["project_name"],
        activity: json["activity"] == null ? null : json["activity"],
        progress: json["progress"] == null ? null : json["progress"],
        dateSubmit: json["date_submit"] == null
            ? null
            : DateTime.parse(json["date_submit"]),
        manHours: json["man_hours"] == null ? null : json["man_hours"],
        idPtfi: json["id_ptfi"] == null ? null : json["id_ptfi"],
        devAction: json["dev_action"] == null ? null : json["dev_action"],
        name: json["assigned"] == null ? null : json["assigned"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        businessUnit:
            json["business_unit"] == null ? null : json["business_unit"],
        requestor:
            json["requestor_name"] == null ? null : json["requestor_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "work_area": workArea == null ? null : workArea,
        "wo_number": woNumber == null ? null : woNumber,
        "project_name": projectName == null ? null : projectName,
        "activity": activity == null ? null : activity,
        "progress": progress == null ? null : progress,
        "date_submit": dateSubmit == null
            ? null
            : "${dateSubmit?.year.toString().padLeft(4, '0')}-${dateSubmit?.month.toString().padLeft(2, '0')}-${dateSubmit?.day.toString().padLeft(2, '0')}",
        "man_hours": manHours == null ? null : manHours,
        "id_ptfi": idPtfi == null ? null : idPtfi,
        "dev_action": devAction == null ? null : devAction,
        "name": name == null ? null : name,
        "start_date": startDate == null
            ? null
            : "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
        "end_date": endDate == null
            ? null
            : "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
        "business_unit": businessUnit == null ? null : businessUnit,
        "requestor": requestor == null ? null : requestor,
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
