import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';

class StockData {
  StockData(this.date, this.price);
  final String date;
  final double price;
}

class StockChart extends StatefulWidget {
  StockChart(String this._code, {Key key}): super(key: key);

  final String _code;

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
      title: ChartTitle(text: 'Half yearly sales analysis'),
      // Enable legend
      legend: Legend(isVisible: true),
      // Enable tooltip
      tooltipBehavior: TooltipBehavior(enable: true),
      series: < ChartSeries >[
        LineSeries < StockData, String >(
          dataSource: _data,
          xValueMapper: (StockData stock, _) => stock.date,
          yValueMapper: (StockData stock, _) => stock.price,
          dataLabelSettings: DataLabelSettings(isVisible: true)
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
    final response = await http.get(BASE_IP + "/stocks/" + widget._code);
    final decodedResponse = json.decode(response.body);

    var xPoints = List < int >.from(decodedResponse["dates"]);
    var yPoints = List < double >.from(decodedResponse["prices"]);

    List < StockData > ret = [];
    for (int i = 0; i < xPoints.length; ++ i) {
      ret.add(StockData(xPoints[i].toString() + " Oct.", yPoints[i]));
    }

    return ret;
  }
}
