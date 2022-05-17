import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// AIzaSyBisx4OhGapnYUTAjV2K1i8UJpG5kdwJNQ
class Auth with ChangeNotifier {
  Timer? _authTimer;
  String? _idToken, userId, email;
  DateTime? _expiryDate;

  String? _tempidToken, tempuserId, tempemail;
  DateTime? _tempexpiryDate;

  Future<void> tempData() async {
    _idToken = _tempidToken;
    userId = tempuserId;
    _expiryDate = _tempexpiryDate;
    email = tempemail;

    final sharedPref = await SharedPreferences.getInstance();

    final userData = json.encode({
      'token': _tempidToken,
      'userId': tempuserId,
      'expiryDate': _tempexpiryDate!.toIso8601String(),
      'email': tempemail,
    });

    sharedPref.setString('userData', userData);

    _autoLogout();

    notifyListeners();
  }

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_idToken != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _expiryDate != null) {
      return _idToken;
    } else {
      return null;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      Uri url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBisx4OhGapnYUTAjV2K1i8UJpG5kdwJNQ');
      var response = await http.post(
        url,
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}),
      );
      var responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw responseData['error']['message'];
      }
      _tempidToken = responseData['idToken'];
      tempuserId = responseData['localId'];
      tempemail = responseData['email'];
      _tempexpiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> logout() async {
    _idToken = null;
    userId = null;
    email = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.clear();

    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpire = _tempexpiryDate!.difference(DateTime.now()).inSeconds;
    // print(timeToExpire);
    _authTimer = Timer(Duration(seconds: timeToExpire), logout);
  }

  Future<bool> autoLogin() async {
    final sharedPref = await SharedPreferences.getInstance();
    if (!sharedPref.containsKey('userData')) {
      return false;
    }
    final myData =
        json.decode(sharedPref.getString('userData')!) as Map<String, dynamic>;

    final expiryDate = DateTime.parse(myData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _idToken = myData['token'];
    userId = myData['userId'];
    _expiryDate = expiryDate;
    email = myData['email'];
    notifyListeners();
    return true;
  }
}
