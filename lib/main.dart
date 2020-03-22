import 'package:flutter/material.dart';
import 'package:castform/homeScreen.dart';
import 'package:castform/api.dart';

void main() => runApp(AppRootWidget());

class AppRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Castform',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Castform'),
    );
  }
}
