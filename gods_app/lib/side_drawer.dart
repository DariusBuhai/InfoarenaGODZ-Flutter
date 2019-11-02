import 'package:flutter/material.dart';
import 'drawer_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SideDrawer extends StatefulWidget {
  SideDrawer({Key key}): super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State < SideDrawer > {

  List < DrawerItem > _drawerItems = [];

  @override 
  initState() {

    super.initState();

    fetchCompanyNames().then((companyNames) {
      setState(() {
        for (var name in companyNames) {
          _drawerItems.add(new DrawerItem(name));
        }
      });
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: _drawerItems.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return DrawerHeader(
              child: Text("Company Names"),
            );
          }

          return ListTile(
            title: Text(_drawerItems[index - 1].name),
            selected: _drawerItems[index - 1].selected,
            onTap: () {
              setState(() {
                _drawerItems[index - 1].selected = !_drawerItems[index - 1].selected;
              });
            }
          );
        }
      ),
    );
  }

  Future < List < String > > fetchCompanyNames() async {
    final response = await http.get("http://172.16.27.221:8000/companies/");
    final decodedResponse = json.decode(response.body);

    List < String > ret = [];
    for (var x in decodedResponse) {
      ret.add(x["name"]);
    }

    return ret;
  }
}
