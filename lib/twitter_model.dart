class Twitter {
  String createdAt;
  String text;
  var expandedUrl;
  String name;
  String profile_image_url;
  String screenName;
  int followers_count;
  int friends_count;
  String doj;
  String description;
  String pburl;
  Twitter(
      {required this.createdAt,
      required this.text,
      required this.expandedUrl,
      required this.name,
      required this.profile_image_url,
      required this.screenName,
      required this.followers_count,
      required this.friends_count,
      required this.doj,
      required this.description,
      required this.pburl});
}
