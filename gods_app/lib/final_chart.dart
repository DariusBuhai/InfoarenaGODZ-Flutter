import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';
import 'package:intl/intl.dart';

class FinalData {
  FinalData(this.rating, this.price);
  final double rating;
  final double price;
}

class FinalChart extends StatefulWidget {
  FinalChart(String name, String code, {Key key}): _name = name, _code = code, super(key: key);

  final String _name;
  final String _code;

  @override
  _FinalChartState createState() => _FinalChartState();
}

class _FinalChartState extends State < FinalChart > {

  List < FinalData > _data = [];

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
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.simpleCurrency()
      ),
      series: < ChartSeries >[
        LineSeries < FinalData, double >(
          dataSource: _data,
          xValueMapper: (FinalData element, _) => element.rating,
          yValueMapper: (FinalData element, _) => element.price,
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

  Future < List < FinalData > > fetchChartDataX() async {
    final response = await http.get(BASE_IP_FINAL_DATA + widget._name + "/" + widget._code);
    final decodedResponse = json.decode(response.body);

    var xPoints = List < double >.from(decodedResponse["rates"]);
    var yPoints = List < double >.from(decodedResponse["prices"]);

    List < FinalData > ret = [];
    for (int i = 0; i < xPoints.length; ++ i) {
      ret.add(FinalData(xPoints[i].toDouble(), yPoints[i].toDouble()));
    }

    return ret;
  }
}
