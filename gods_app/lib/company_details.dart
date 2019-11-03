import 'package:flutter/material.dart';
import 'stock_chart.dart';
import 'news_row.dart';


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
        backgroundColor: Colors.black87,
      ),
      body: ListView(
        children: < Widget > [
          Column(
            children: < Widget > [
              SizedBox(height: 20.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "     Stock Prices",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.0),
              Container(
                child: StockChart(widget._companyCode),
              ),
            ],
          ),
          SizedBox(height: 20.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "     Relevant news",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.0),
          NewsRow(widget._companyName),
        ],
      ),
    );
  }
}
