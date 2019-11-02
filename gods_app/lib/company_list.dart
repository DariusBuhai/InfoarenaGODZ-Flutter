import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'constants.dart';

import 'company_details.dart';

class CompanyList extends StatefulWidget {
  CompanyList({Key key}): super(key: key);

  @override
  _CompanyListState createState() => _CompanyListState();
}

class _CompanyListState extends State < CompanyList > {

  List < String > _companyList = [];

  @override 
  initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer t) => _updateCompanyList());
  }

  @override 
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _companyList.length,
        itemBuilder: (BuildContext context, int index) {

          String currentName = _companyList[index];
          return Container(
            margin: EdgeInsets.all(5),
            child: Card(
              child: ListTile(
                title: Text(currentName),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CompanyDetails(currentName);
                      }
                    ),
                  );
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

  void _updateCompanyList() {
    fetchCompanyNames().then((companyNames) {
      setState(() {
        _companyList = companyNames; 
      });
    });
  }

  Future < List < String > > fetchCompanyNames() async {
    final response = await http.get(BASE_IP + "/companies/");
    final decodedResponse = json.decode(response.body);

    List < String > ret = [];
    for (var x in decodedResponse) {
      ret.add(x["name"]);
    }

    return ret;
  }
}
