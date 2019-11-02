import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class StockChart extends StatefulWidget {
  StockChart (this._forWho, {Key key}): super(key: key);

  final String _forWho;

  @override
  _StockChartState createState() => _StockChartState();
}

class _StockChartState extends State < StockChart > {

  double _minX = 0, _maxX = 0, _minY = 0, _maxY = 0;
  List < FlSpot > _stockSpots = [];

  @override
  initState() {
    super.initState();
    updateChartData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            child: FlChart(
              chart: LineChart(
                LineChartData(
                  minX: _minX,
                  maxX: _maxX,
                  minY: _minY,
                  maxY: _maxY,
                  lineBarsData: [
                    LineChartBarData(
                      spots: _stockSpots.length != 0 ? _stockSpots : [FlSpot(0, 0)],
                      isCurved: true,
                      colors: [Colors.blue],
                      barWidth: 3,
                      isStrokeCapRound: false,
                      dotData: const FlDotData(
                        show: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void updateChartData() {
    fetchChartDataX().then((chartData) {
      setState(() {
        _stockSpots = chartData;
        _minX = _maxX = _stockSpots[0].x;
        _minY = _maxY = _stockSpots[0].y;
        for (var x in _stockSpots) {
          _minX = min(_minX, x.x);
          _minY = min(_minY, x.y);
          _maxX = max(_maxX, x.x);
          _maxY = max(_maxY, x.y);
        }
      });
    });
  }

  Future < List < FlSpot > > fetchChartDataX() async {
    // TODO modifica nume companie ca lumea
    final response = await http.get("http://172.16.27.221:8000/stocks/VOD");
    final decodedResponse = json.decode(response.body);

    var xPoints = List < double >.from(decodedResponse["dates"]);
    var yPoints = List < double >.from(decodedResponse["prices"]);
    List < FlSpot > ret = [];

    for (int i = 0; i < xPoints.length; ++ i) {
      ret.add(FlSpot(xPoints[i], yPoints[i]));
    }

    return ret;
  }
}
