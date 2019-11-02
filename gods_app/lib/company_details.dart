import 'package:flutter/material.dart';
import 'stock_chart.dart';


class CompanyDetails extends StatefulWidget {

  CompanyDetails(this._companyName, {Key key}): super(key: key);

  final String _companyName;

  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State < CompanyDetails > {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._companyName),
      ),
      body: Column(
        children: < Widget > [
          Container(
            child: StockChart(),
          ),
        ],
      ),
    );
  }
}
