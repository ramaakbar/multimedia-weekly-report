import 'dart:convert';
import 'dart:io';

import 'package:weekly_report/models/karyawan_model.dart';
import 'package:weekly_report/models/weekly_model.dart';
import 'package:weekly_report/models/workarea_model.dart' as wa;
import 'package:weekly_report/models/crew_model.dart' as cm;
import 'package:weekly_report/models/businessUnit_model.dart' as bu;
import 'package:weekly_report/models/report_category_model.dart' as rc;
import 'package:weekly_report/models/report_businessunit_model.dart' as rb;
import 'package:weekly_report/repo/api_status.dart';
import 'package:weekly_report/utils/constants.dart';
import 'package:http/http.dart' as http;

class WeeklyServices {
  static Future<Object> getWeekly() async {
    try {
      var url = Uri.parse('http://10.0.2.2:40/weekly_api/api/get_weekly.php');
      var response = await http.get(url);
      // var response =
      //     await Future.delayed(Duration(seconds: 5), () => http.get(url));

      if (response.statusCode == SUCCESS) {
        return Success(response: weeklyModelFromJson(response.body).data);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'No Data');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknow Error');
    }
  }

  static Future<Object> getKaryawan() async {
    try {
      var url = Uri.parse('http://10.0.2.2:40/weekly_api/api/get_karyawan.php');
      var response = await http.get(url);
      // var response =
      //     await Future.delayed(Duration(seconds: 5), () => http.get(url));

      if (response.statusCode == SUCCESS) {
        return Success(response: karyawanFromJson(response.body).data);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'No Data');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknow Error');
    }
  }

  static Future<Object> getWorkArea() async {
    try {
      var url = Uri.parse('http://10.0.2.2:40/weekly_api/api/get_workarea.php');
      var response = await http.get(url);
      return Success(response: wa.workAreaModelFromJson(response.body).data);
    } catch (e) {
      return 'cant get work area data';
    }
  }

  static Future<Object> getCrew() async {
    try {
      var url = Uri.parse('http://10.0.2.2:40/weekly_api/api/get_crew.php');
      var response = await http.get(url);
      return Success(response: cm.crewModelFromJson(response.body).data);
    } catch (e) {
      return 'cant get work area data';
    }
  }

  static Future<Object> getBusiness() async {
    try {
      var url = Uri.parse('http://10.0.2.2:40/weekly_api/api/get_business.php');
      var response = await http.get(url);
      return Success(response: bu.businessUnitFromJson(response.body).data);
    } catch (e) {
      return 'cant get business unit data';
    }
  }

  static Future<Object> postWeekly(Map data) async {
    try {
      var url = Uri.parse('http://10.0.2.2:40/weekly_api/api/post_weekly.php');

      var body = jsonEncode(data);

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == SUCCESS) {
        return Success(response: weeklyModelFromJson(response.body).data);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'No Data');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknow Error');
    }
  }

  static Future<Object> deleteWeekly(String id) async {
    try {
      var url =
          Uri.parse('http://10.0.2.2:40/weekly_api/api/delete_weekly.php');

      var body = jsonEncode({'wo_number': id});

      var response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == SUCCESS) {
        return Success(response: weeklyModelFromJson(response.body).data);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'No Data');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknow Error');
    }
  }

  static Future<Object> updateWeekly(Map data) async {
    try {
      var url =
          Uri.parse('http://10.0.2.2:40/weekly_api/api/update_weekly.php');
      var body = jsonEncode(data);

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == SUCCESS) {
        return Success(response: weeklyModelFromJson(response.body).data);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'No Data');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknow Error');
    }
  }

  static Future<Object> getReportCategory(Map par) async {
    try {
      final queryParameters = par;
      var url = Uri.parse(
          'http://10.0.2.2:40/weekly_api/api/get_report_category.php?start_date=${queryParameters['startDate']}&end_date=${queryParameters['endDate']}');
      var response = await http.get(url);
      // var response =
      //     await Future.delayed(Duration(seconds: 5), () => http.get(url));

      if (response.statusCode == SUCCESS) {
        return Success(
            response: rc.reportCategoryModelFromJson(response.body).data);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'No Data');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknow Error');
    }
  }

  static Future<Object> getReportBusinessUnit(Map par) async {
    try {
      final queryParameters = par;
      var url = Uri.parse(
          'http://10.0.2.2:40/weekly_api/api/get_report_businessUnit.php?start_date=${queryParameters['startDate']}&end_date=${queryParameters['endDate']}');
      var response = await http.get(url);
      // var response =
      //     await Future.delayed(Duration(seconds: 5), () => http.get(url));

      if (response.statusCode == SUCCESS) {
        return Success(
            response: rb.reportBusinessunitModelFromJson(response.body).data);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'No Data');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknow Error');
    }
  }
}
