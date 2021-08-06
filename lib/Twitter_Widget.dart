import 'package:flutter/material.dart';
import 'package:twitter/Profile_Intro_Widget.dart';
import 'package:twitter/tweets_view.dart';

class TwitterWidget extends StatelessWidget {
  String query;
  TwitterWidget(this.query);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Profile_Intro(query),
          Row(children: [
            Container(
                height: 60,
                width: 60,
                child: Image.network(
                  'http://assets.stickpng.com/images/580b57fcd9996e24bc43c53e.png',
                )),
            Text("Tweets", style: TextStyle(fontSize: 28)),
          ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 3, 10, 0),
            child: Divider(
              thickness: 2,
              color: Colors.blueGrey,
            ),
          ),
          Tweets_View(query),
        ]);
  }
}
