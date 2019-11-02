import 'package:flutter/material.dart';
import 'slide_item.dart';

class NewsRow extends StatefulWidget {
  NewsRow({Key key}): super(key: key);

  @override
  _NewsRowState createState() => _NewsRowState();
}

class _NewsRowState extends State < NewsRow > {

  List restaurants = [
    {
      "title": "Happy Jones",
      "address": "1278 Loving Acres RoadKansas City, MO 64110",
      "rating": "4.5"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/2.4,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: restaurants == null ? 0 :restaurants.length,
        itemBuilder: (BuildContext context, int index) {
          Map newsPiece = restaurants[index];
          return Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: SlideItem(
              img: " ",
              title: newsPiece["title"],
              address: newsPiece["address"],
              rating: newsPiece["rating"],
            ),
          );
        },
      ),
    );
  }
}

