import 'package:flutter/material.dart';
import 'stock_chart.dart';


class CompanyDetails extends StatefulWidget {

  CompanyDetails(this._companyName, this._companyCode, {Key key}): super(key: key);

  final String _companyName, _companyCode;

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
            child: StockChart(widget._companyCode),
          ),
        ],
      ),
    );
  }
}
