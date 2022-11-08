// To parse this JSON data, do
//
//     final teamFeedModel = teamFeedModelFromJson(jsonString);

import 'dart:convert';

List<TeamFeedModel> teamFeedModelFromJson(String str) =>
    List<TeamFeedModel>.from(
        json.decode(str).map((x) => TeamFeedModel.fromJson(x)));

String teamFeedModelToJson(List<TeamFeedModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamFeedModel {
  TeamFeedModel({
    required this.id,
    required this.author,
    required this.photo,
    required this.text,
    required this.postedOn,
    required this.isVid,
    required this.numberOfLikes,
    required this.numberOfComments,
  });

  String id;
  Author author;
  String photo;
  String text;
  DateTime postedOn;
  bool isVid;
  int numberOfLikes;
  int numberOfComments;

  factory TeamFeedModel.fromJson(Map<String, dynamic> json) => TeamFeedModel(
        id: json["id"],
        author: Author.fromJson(json["author"]),
        photo: json["photo"],
        text: json["text"],
        postedOn: DateTime.parse(json["posted_on"]),
        isVid: json["isVid"],
        numberOfLikes: json["number_of_likes"],
        numberOfComments: json["number_of_comments"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author.toJson(),
        "photo": photo,
        "text": text,
        "posted_on": postedOn.toIso8601String(),
        "isVid": isVid,
        "number_of_likes": numberOfLikes,
        "number_of_comments": numberOfComments,
      };
}

class Author {
  Author({
    required this.firebase,
    required this.profileImage,
    required this.name,
    required this.email,
  });

  String firebase;
  String profileImage;
  String name;
  String email;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        firebase: json["firebase"],
        profileImage: json["profileImage"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "firebase": firebase,
        "profileImage": profileImage,
        "name": name,
        "email": email,
      };
}
