import 'package:flutter/material.dart';
import 'package:flutter_travel_concept/util/places.dart';
import 'package:flutter_travel_concept/widgets/horizontal_place_item.dart';
import 'package:flutter_travel_concept/widgets/icon_badge.dart';
import 'package:flutter_travel_concept/widgets/search_bar.dart' as Search;
import 'package:flutter_travel_concept/widgets/vertical_place_item.dart';

import 'details.dart';

class Home extends StatelessWidget {
  final TextEditingController _searchControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Where are you \ngoing?",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
              child: Search.SearchBar(searchControl: _searchControl, onSearch: (query) => _handleSearch(context, query))
          ),
          buildHorizontalList(context),
          buildVerticalList(),
        ],
      ),
    );
  }

  buildHorizontalList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
          child: Text(
            "Featured",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20.0),
          height: 250.0,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            primary: false,
            itemCount: featured == null ? 0 : featured.length,
            itemBuilder: (BuildContext context, int index) {
              Map place = featured.reversed.toList()[index];
              return HorizontalPlaceItem(place: place);
            },
          ),
        ),
      ],
    );
  }

  buildVerticalList() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: places == null ? 0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places[index];
          return VerticalPlaceItem(place: place);
        },
      ),
    );
  }
  void _handleSearch(BuildContext context, String query) {
    var matchedPlace = places.firstWhere((place) => place["name"].toString().toLowerCase() == query.toLowerCase(), orElse: () => null);
    if (matchedPlace != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Details(place: matchedPlace)));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("No place found"),
            content: Text("No places available with the name '$query'."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
