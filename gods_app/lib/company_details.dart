import 'package:flutter/material.dart';
import 'stock_chart.dart';
import 'slide_item.dart';


List restaurants = [
  {
    "title": "Happy Jones",
    "address": "1278 Loving Acres RoadKansas City, MO 64110",
    "rating": "4.5"
  }
];

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
          Text("\nStock Prices", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
          Container(
            child: StockChart(widget._companyCode),
          ),
          Container(
            height: MediaQuery.of(context).size.height/2.4,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: restaurants == null ? 0 :restaurants.length,
              itemBuilder: (BuildContext context, int index) {
                Map restaurant = restaurants[index];

                return Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: SlideItem(
                    img: " ",
                    title: restaurant["title"],
                    address: restaurant["address"],
                    rating: restaurant["rating"],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
