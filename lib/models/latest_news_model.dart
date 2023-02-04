import 'dart:convert';

LatestNewsModel latestNewsModelFromJson(String str) =>
    LatestNewsModel.fromJson(json.decode(str));

String latestNewsModelToJson(LatestNewsModel data) =>
    json.encode(data.toJson());

class LatestNewsModel {
  LatestNewsModel({
    this.status,
    this.message,
  });

  int? status;
  Message? message;

  factory LatestNewsModel.fromJson(Map<String, dynamic> json) =>
      LatestNewsModel(
        status: json["status"],
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message!.toJson(),
      };
}

class Message {
  Message({
    this.notice,
  });

  List<LatestNewsList>? notice;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        notice: List<LatestNewsList>.from(
            json["notice"].map((x) => LatestNewsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notice": List<dynamic>.from(notice!.map((x) => x.toJson())),
      };
}

class LatestNewsList {
  LatestNewsList({
    required this.newsId,
    required this.newsTt,
    required this.newsTitle,
    required this.newsDesc,
    required this.newsLink,
    required this.loginType,
  });

  String newsId;
  DateTime newsTt;
  String newsTitle;
  String newsDesc;
  String newsLink;
  String loginType;

  factory LatestNewsList.fromJson(Map<String, dynamic> json) => LatestNewsList(
        newsId: json["NEWS_ID"],
        newsTt: DateTime.parse(json["NEWS_TT"]),
        newsTitle: json["NEWS_TITLE"],
        newsDesc: json["NEWS_DESC"],
        newsLink: json["NEWS_LINK"],
        loginType: json["LOGIN_TYPE"],
      );

  Map<String, dynamic> toJson() => {
        "NEWS_ID": newsId,
        "NEWS_TT": newsTt.toIso8601String(),
        "NEWS_TITLE": newsTitle,
        "NEWS_DESC": newsDesc,
        "NEWS_LINK": newsLink,
        "LOGIN_TYPE": loginType,
      };
}
