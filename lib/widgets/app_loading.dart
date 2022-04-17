import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(
            color: Colors.blue,
            strokeWidth: 4,
          )),
    );
  }
}