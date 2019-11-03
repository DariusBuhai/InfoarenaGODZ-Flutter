import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'slide_item.dart';
import 'dart:convert';
import 'constants.dart';

class NewsData {
  NewsData(this.title, this.content, this.rating);
  final String title;
  final String content;
  final double rating;
}

class NewsRow extends StatefulWidget {
  NewsRow(String code, {Key key}): _code = code, super(key: key);

  final String _code;

  @override
  _NewsRowState createState() => _NewsRowState();
}

class _NewsRowState extends State < NewsRow > {

  List _news = [];

  @override
  initState() {
    super.initState();
    updateNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/2.4,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _news == null ? 0 :_news.length,
        itemBuilder: (BuildContext context, int index) {
          Map newsPiece = _news[index];
          return Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: SlideItem(
              title: newsPiece["title"],
              content: newsPiece["content"],
              rating: newsPiece["rating"],
            ),
          );
        },
      ),
    );
  }

  void updateNewsData() {
    fetchChartDataX().then((newsData) {
      setState(() {
        _news = newsData;
      });
    });
  }

  Future < List < NewsData > > fetchChartDataX() async {
    final response = await http.get(BASE_IP_NEWS + widget._code);
    final decodedResponse = json.decode(response.body);

    print(decodedResponse[0].runtimeType);

    List < NewsData > ret = [];
    // for (var element in decodedResponse) {
    //   ret.add(new NewsData(
    //     element["title"],
    //     element["description"],
    //     element["rating"]
    //   ));
    // }

    return ret;
  }
}

