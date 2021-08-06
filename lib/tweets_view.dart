import 'package:flutter/material.dart';
import 'package:twitter/twitter_api.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Tweets_View extends StatelessWidget {
  String query;
  Tweets_View(this.query);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<dynamic>>(
          future: gettweets(query),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text('Loading...'),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) => ListTile(
                        contentPadding: EdgeInsets.only(left: 10.0, right: 10),
                        tileColor: Colors.white,
                        title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              fit: BoxFit.contain,
                                              image: new NetworkImage(snapshot
                                                  .data?[index]
                                                  .profile_image_url))),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                        child: Text(
                                      snapshot.data?[index].text,
                                      style: TextStyle(
                                          fontSize: 18, wordSpacing: 2),
                                    )),
                                  ]),
                              Divider(
                                height: 10,
                                color: Colors.blueGrey,
                                // thickness: 3,
                              )
                            ]),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Scaffold(
                                  appBar: AppBar(),
                                  body: WebView(
                                    javascriptMode: JavascriptMode.unrestricted,
                                    initialUrl:
                                        (snapshot.data?[index].expandedUrl),
                                  ),
                                ),
                              ));
                        },
                      ));
            }
          }),
    );
  }
}
