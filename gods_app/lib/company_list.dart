import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'company_details.dart';

class CompanyList extends StatefulWidget {
  CompanyList({Key key}): super(key: key);

  @override
  _CompanyListState createState() => _CompanyListState();
}

class _CompanyListState extends State < CompanyList > {

  List < String > _drawerItems = [];

  @override 
  initState() {
    super.initState();
    fetchCompanyNames().then((companyNames) {
      setState(() {
        for (var name in companyNames) {
          _drawerItems.add(name);
        }
      });
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _drawerItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(5),
            child: Card(
              child: ListTile(
                title: Text(_drawerItems[index]),
                onTap: () {
                },
              ),
              elevation: 10,
            ),
          );
        }
      ),
      color: Colors.white,
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
