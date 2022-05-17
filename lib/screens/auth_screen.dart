import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/screens/home_screen.dart';
import 'package:weekly_report/screens/template.dart';
import 'package:weekly_report/view_models/auth.dart' as a;

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => Duration(milliseconds: 1000);

  Future<String?> _authUserLogin(LoginData data) {
    // print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      try {
        await Provider.of<a.Auth>(context, listen: false)
            .login(data.name, data.password);
      } catch (e) {
        return e.toString();
      }

      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return 'test';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Multimedia Weekly Report',
      // logo: AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: _authUserLogin,
      // onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Provider.of<a.Auth>(context, listen: false).tempData();
      },
      onRecoverPassword: _recoverPassword,
      hideForgotPasswordButton: true,
      theme: LoginTheme(
        titleStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 23.0,
        ),
      ),
    );
  }
}
