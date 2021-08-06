import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twitter/twitter_model.dart';

Future<List<Twitter>> gettweets(query) async {
  Uri uri = Uri.parse(
      'https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=$query&count=200');
  String host = uri.host;
  String path = uri.path;
  Map<String, String> queryParameter = uri.queryParameters;
  var res = await http.get(Uri.https(host, path, queryParameter), headers: {
    'Authorization':
        'Bearer AAAAAAAAAAAAAAAAAAAAADIiSQEAAAAA%2BtiGa2BWt6VhwajDC6CeU0HAmfE%3DegAPMl7m3wJPLjubUKNRwH0GO0wyjKRPEIooir8TvQZzg0ODhQ'
  });
  List<Twitter> tweets = [];
  var jsondata = jsonDecode(res.body);

  //print(jsondata);
  if (jsondata.length != 0) {
    for (var i in jsondata) {
      var text = i['text'];
      var createdAt = i['created_at'];
      var name = i['user']['name'];
      var description = i['user']['description'];
      var pburl = i['user']['profile_banner_url'] ?? "";
      var urls = i['entities']['urls'];
      var profile_image_url = i['user']['profile_image_url_https'] ?? '';

      String revImg = profile_image_url.split('').reversed.join('');
      profile_image_url = revImg.substring(0, 4) +
          '004x004' +
          revImg.substring(10, revImg.length);
      profile_image_url = profile_image_url.split('').reversed.join('');
      //print(profile_image_url);
      var expandedUrl = 'http://google.com';
      var screenName = i['user']['screen_name'];
      var followersCount = i['user']['followers_count'];
      var friendsCount = i['user']['friends_count'];
      var doj = i['user']['created_at'];
      if (urls.length != 0) {
        expandedUrl = i['entities']['urls'][0]['expanded_url'];
        //print(expandedUrl);
      }
      //print(description);
      Twitter tweet = new Twitter(
          text: text,
          createdAt: createdAt,
          expandedUrl: expandedUrl,
          name: name,
          profile_image_url: profile_image_url,
          screenName: screenName,
          followers_count: followersCount,
          friends_count: friendsCount,
          doj: doj,
          description: description,
          pburl: pburl);
      tweets.add(tweet);
    }
  }
  return tweets;
}
