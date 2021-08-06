import 'package:flutter/material.dart';
import 'dart:ui';
import 'twitter_api.dart';

class Profile_Intro extends StatelessWidget {
  String query;
  Profile_Intro(this.query);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: gettweets(query),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: Text('Loading...'),
            );
          } else {
            print(snapshot.data?[0].profile_image_url);
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(3, 10, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //padding: EdgeInsets.all(100),
                          width: 110.0,
                          height: 90.0,

                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                      snapshot.data?[0].profile_image_url))),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                snapshot.data?[0].name,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text("@" + snapshot.data?[0].screenName),
                            ]),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                      //shadowColor: Colors.white24,
                      elevation: 0,
                      child: Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          snapshot.data?[0].description,
                          style: TextStyle(fontSize: 18),
                        ),
                      )),
                  SizedBox(height: 5),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                      child: Row(children: [
                        Text((snapshot.data?[0].friends_count).toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("   Following     ",
                            style: TextStyle(fontSize: 18)),
                        Text((snapshot.data?[0].followers_count).toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("   Followers     ",
                            style: TextStyle(fontSize: 18)),
                      ]))
                ]);
          }
        });
  }
}
