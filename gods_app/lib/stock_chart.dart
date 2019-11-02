import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';

class StockData {
  StockData(this.date, this.price);
  final double date;
  final double price;
}

class StockChart extends StatefulWidget {
  StockChart({Key key}): super(key: key);

  @override
  _StockChartState createState() => _StockChartState();
}

class _StockChartState extends State < StockChart > {

  List < StockData > _data = [];

  @override
  initState() {
    super.initState();
    updateChartData();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: < ChartSeries >[
        LineSeries < StockData, double >(
          dataSource: _data,
          xValueMapper: (StockData stock, _) => stock.date,
          yValueMapper: (StockData stock, _) => stock.price,
        )
      ],
    );
  }

  void updateChartData() {
    fetchChartDataX().then((chartData) {
      setState(() {
        _data = chartData;
      });
    });
  }

  Future < List < StockData > > fetchChartDataX() async {
    // TODO modifica nume companie ca lumea
    final response = await http.get(BASE_IP + "/stocks/VOD");
    final decodedResponse = json.decode(response.body);

    var xPoints = List < double >.from(decodedResponse["dates"]);
    var yPoints = List < double >.from(decodedResponse["prices"]);

    List < StockData > ret = [];
    for (int i = 0; i < xPoints.length; ++ i) {
      ret.add(StockData(xPoints[i], yPoints[i]));
    }

    return ret;
  }
}
