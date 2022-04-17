import 'dart:convert';

WeeklyError WeeklyErrorFromJson(String str) =>
    WeeklyError.fromJson(json.decode(str));

String WeeklyErrorToJson(WeeklyError data) => json.encode(data.toJson());

class WeeklyError {
  WeeklyError({
    this.code,
    this.message,
  });

  int? code = 0;
  String? message = '';

  factory WeeklyError.fromJson(Map<String, dynamic> json) => WeeklyError(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
      };
}
