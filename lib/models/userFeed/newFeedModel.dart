// To parse this JSON data, do
//
//     final newUserFeedModel = newUserFeedModelFromJson(jsonString);

import 'dart:convert';

import '../../models/userFeed/user_feed_model.dart';

NewUserFeedModel newUserFeedModelFromJson(String str) =>
    NewUserFeedModel.fromJson(json.decode(str));

String newUserFeedModelToJson(NewUserFeedModel data) =>
    json.encode(data.toJson());

class NewUserFeedModel {
  NewUserFeedModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<UserFeedModel> results;

  factory NewUserFeedModel.fromJson(Map<String, dynamic> json) =>
      NewUserFeedModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<UserFeedModel>.from(json["results"].map((x) => UserFeedModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
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
