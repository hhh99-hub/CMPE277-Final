import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchControl;
  final Function(String) onSearch;

  SearchBar({required this.searchControl, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: TextField(
        controller: searchControl,
        onSubmitted: onSearch, // Handle the search when enter is pressed
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: "E.g: New York, United States",
          prefixIcon: Icon(Icons.location_on, color: Colors.blueGrey[300]),
          hintStyle: TextStyle(fontSize: 15.0, color: Colors.blueGrey[300]),
        ),
      ),
    );
  }
}
