// To parse this JSON data, do
//
//     final businessUnit = businessUnitFromJson(jsonString);

import 'dart:convert';

BusinessUnit businessUnitFromJson(String str) =>
    BusinessUnit.fromJson(json.decode(str));

String businessUnitToJson(BusinessUnit data) => json.encode(data.toJson());

class BusinessUnit {
  BusinessUnit({
    required this.status,
    required this.data,
  });

  Status status;
  List<Datum> data;

  factory BusinessUnit.fromJson(Map<String, dynamic> json) => BusinessUnit(
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
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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
