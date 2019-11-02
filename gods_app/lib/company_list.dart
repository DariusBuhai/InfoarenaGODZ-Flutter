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

  List < String > _companyNameList = [];
  List < String > _companyCodeList = [];

  @override 
  initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer t) => _updateCompanyList());
  }

  @override 
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _companyNameList.length,
        itemBuilder: (BuildContext context, int index) {

          String currentName = _companyNameList[index];
          String currentCode = _companyCodeList[index];

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
                        return CompanyDetails(currentName, currentCode);
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

    fetchCompanyData("name").then((data) {
      setState(() {
        _companyNameList = data; 
      });
    });

    fetchCompanyData("code").then((data) {
      setState(() {
        _companyCodeList = data; 
      });
    });
  }

  Future < List < String > > fetchCompanyData(String what) async {
    final response = await http.get(BASE_IP + "/companies/");
    final decodedResponse = json.decode(response.body);

    List < String > ret = [];
    for (var x in decodedResponse) {
      ret.add(x[what]);
    }

    return ret;
  }
}
