import 'package:flutter/material.dart';
import 'main.dart';

class InputSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            onTap: () {
              showSearch(context: context, delegate: TwitterSearchUser());
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.cyan),
                  borderRadius: BorderRadius.circular(10.0)),
              hintText: 'Search Username',
            ),
          ),
        ),
        SizedBox(width: 15),
      ]),
    );
  }
}
