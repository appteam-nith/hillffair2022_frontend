// To parse this JSON data, do
//
//     final userFeedModel = userFeedModelFromJson(jsonString);

import 'dart:convert';

List<UserFeedModel> userFeedModelFromJson(String str) => List<UserFeedModel>.from(json.decode(str).map((x) => UserFeedModel.fromJson(x)));

String userFeedModelToJson(List<UserFeedModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserFeedModel {
    UserFeedModel({
        required this.id,
        required this.author,
        required this.photo,
        required this.text,
        required this.postedOn,
        required this.numberOfLikes,
        required this.numberOfComments,

    });

    String id;
    Author author;
    String photo;
    String text;
    DateTime postedOn;
    int numberOfLikes;
    int numberOfComments;

    factory UserFeedModel.fromJson(Map<String, dynamic> json) => UserFeedModel(
        id: json["id"],
        author: Author.fromJson(json["author"]),
        photo: json["photo"] == null ? "http://res.cloudinary.com/dfinmhios/image/upload/v1649642869/wbiob4xouvpkbvclo0iw.jpg" : json["photo"],
        text: json["text"],
        postedOn: DateTime.parse(json["posted_on"]),
        numberOfLikes: json["number_of_likes"],
        numberOfComments: json["number_of_comments"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "author": author.toJson(),
        "photo": photo == null ? null : photo,
        "text": text,
        "posted_on": postedOn.toIso8601String(),
        "number_of_likes": numberOfLikes,
        "number_of_comments": numberOfComments,
    };
}

class Author {
    Author({
        required this.username,
    });

    String username;

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
    };
}




