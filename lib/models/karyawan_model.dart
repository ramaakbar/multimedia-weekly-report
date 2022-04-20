// To parse this JSON data, do
//
//     final karyawan = karyawanFromJson(jsonString);

import 'dart:convert';

Karyawan karyawanFromJson(String str) => Karyawan.fromJson(json.decode(str));

String karyawanToJson(Karyawan data) => json.encode(data.toJson());

class Karyawan {
  Karyawan({
    required this.status,
    required this.data,
  });

  Status status;
  List<Datum> data;

  factory Karyawan.fromJson(Map<String, dynamic> json) => Karyawan(
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
    required this.username,
  });

  String idPtfi;
  String username;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idPtfi: json["id_ptfi"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id_ptfi": idPtfi,
        "username": username,
      };
  @override
  String toString() => username;
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
