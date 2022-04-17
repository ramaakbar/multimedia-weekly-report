// To parse this JSON data, do
//
//     final crewModel = crewModelFromJson(jsonString);

import 'dart:convert';

CrewModel crewModelFromJson(String str) => CrewModel.fromJson(json.decode(str));

String crewModelToJson(CrewModel data) => json.encode(data.toJson());

class CrewModel {
  CrewModel({
    required this.status,
    required this.data,
  });

  Status status;
  List<Datum> data;

  factory CrewModel.fromJson(Map<String, dynamic> json) => CrewModel(
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
    required this.idPtfi,
    required this.name,
  });

  String idPtfi;
  String name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idPtfi: json["id_ptfi"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id_ptfi": idPtfi,
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
