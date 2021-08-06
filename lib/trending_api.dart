import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Trending>> gettrends() async {
  Uri uri =
      Uri.parse('https://api.twitter.com/1.1/trends/place.json?id=23424848');
  String host = uri.host;
  String path = uri.path;
  Map<String, String> queryParameter = uri.queryParameters;
  var res = await http.get(Uri.https(host, path, queryParameter), headers: {
    'Authorization':
        'Bearer AAAAAAAAAAAAAAAAAAAAADIiSQEAAAAA%2BtiGa2BWt6VhwajDC6CeU0HAmfE%3DegAPMl7m3wJPLjubUKNRwH0GO0wyjKRPEIooir8TvQZzg0ODhQ'
  });
  List<Trending> trends = [];
  var jsondata = jsonDecode(res.body);
  jsondata = jsondata[0]['trends'];
  //print(jsondata);
  for (var i in jsondata) {
    var name = i['name'] ?? '';
    //print(name);
    var url = i['url'] ?? '';
    var numoftweets = i['tweet_volume'];
    Trending trend =
        new Trending(name: name, url: url, numoftweets: numoftweets);
    trends.add(trend);
  }
  return trends;
}

class Trending {
  String name;
  String url;
  var numoftweets;
  Trending({required this.name, required this.url, required this.numoftweets});
}
