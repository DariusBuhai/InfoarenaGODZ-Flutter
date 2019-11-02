import 'package:flutter/material.dart';
import 'side_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final appTitle = 'God\'s App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('cartor')),
      drawer: SideDrawer(),
    );
  }
}
