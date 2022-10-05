class Links {
  String url;
  String type;

  Links.fromJson(Map json)
      : url = json['url'],
        type = json['type'];
}
