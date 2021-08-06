import 'package:flutter/material.dart';
import 'package:twitter/Input_Search_Bar.dart';
import 'package:twitter/Profile_Intro_Widget.dart';
import 'package:twitter/Twitter_Widget.dart';
import 'package:twitter/trending_api.dart';
import 'package:twitter/twitter_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'twitter_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TwitterView(),
    );
  }
}

class TwitterView extends StatefulWidget {
  const TwitterView({Key? key}) : super(key: key);

  @override
  _TwitterViewState createState() => _TwitterViewState();
}

class _TwitterViewState extends State<TwitterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Twitter', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: TwitterSearchUser());
              },
              icon: Icon(
                Icons.search,
              )),
        ],
      ),
      body: Column(children: <Widget>[
        Container(padding: EdgeInsets.only(top: 10), child: InputSearchBar()),
        SizedBox(height: 20),
        Row(children: <Widget>[
          Flexible(
            child: Container(
                height: 60,
                width: 60,
                child: Image.network(
                  'http://assets.stickpng.com/images/580b57fcd9996e24bc43c53e.png',
                )),
          ),
          Text("Trending in India", style: TextStyle(fontSize: 28)),
          SizedBox(width: 100),
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(
                Icons.restart_alt_sharp,
              )),
        ]),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Divider(
            thickness: 2,
            color: Colors.blueGrey,
          ),
        ),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
              future: gettrends(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Text('Loading...'),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) => ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      appBar: AppBar(),
                                      body: WebView(
                                        javascriptMode:
                                            JavascriptMode.unrestricted,
                                        initialUrl: (snapshot.data?[index].url),
                                      ),
                                    ),
                                  ));
                            },
                            title: Container(
                              // color: Colors.grey.shade200,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(children: [
                                    Text(" " + (index.toInt() + 1).toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blueAccent)),
                                    Text("   " + snapshot.data?[index].name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blueAccent)),
                                  ]),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 28, top: 5),
                                    child: Text(
                                        (snapshot.data?[index].numoftweets)
                                                    .toString() !=
                                                "null"
                                            ? (snapshot.data?[index]
                                                        .numoftweets)
                                                    .toString() +
                                                "  tweets"
                                            : "loading... tweets",
                                        style: TextStyle(fontSize: 14)),
                                  )
                                ],
                              ),
                            ),
                            dense: true,
                            focusColor: Colors.black,
                          ));
                }
              }),
        )
      ]),
    );
  }
}

class TwitterSearchUser extends SearchDelegate<Twitter> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (!query.isEmpty) query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.isEmpty ? Text('') : TwitterWidget(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Text('');
    } else {
      return FutureBuilder<List<dynamic>>(
          future: gettweets(query),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text('Loading...'),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.length == 0 ? 0 : 1,
                  itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Scaffold(
                                      appBar: AppBar(),
                                      body: FutureBuilder<dynamic>(
                                          future: gettweets(query),
                                          builder: (context, snapshot) {
                                            if (snapshot.data == null) {
                                              return Center(
                                                child: Text('Loading'),
                                              );
                                            } else {
                                              //return Text(snapshot.data?.fullURL ?? '');
                                              return TwitterWidget(query);
                                            }
                                          }),
                                    )));
                      },
                      title: Container(
                        width: 200,
                        height: 100,
                        child: Card(
                            elevation: 5,
                            child: Row(children: [
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(left: 40),
                                  width: 90,
                                  height: 90,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          image: new NetworkImage(snapshot
                                              .data?[index]
                                              .profile_image_url))),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data?[index].name,
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          "@" +
                                              snapshot.data?[index].screenName,
                                          style: TextStyle(fontSize: 18)),
                                    ]),
                              )
                            ])),
                      )));
            }
          });
    }
  }
}
