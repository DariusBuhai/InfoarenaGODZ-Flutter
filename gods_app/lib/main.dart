import 'package:flutter/material.dart';
import 'package:gods_app/const.dart';
import 'company_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final appTitle = 'FTSE 100 - Analytics';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      //theme: Constants.lightTheme,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {

  bool isDark = false;

  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.black87),
      body: CompanyList(),
    );
  }
}
