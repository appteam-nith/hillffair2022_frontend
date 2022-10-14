// To parse this JSON data, do
//
//     final getCommentsModel = getCommentsModelFromJson(jsonString);

import 'dart:convert';

GetCommentsModel getCommentsModelFromJson(String str) => GetCommentsModel.fromJson(json.decode(str));

String getCommentsModelToJson(GetCommentsModel data) => json.encode(data.toJson());

class GetCommentsModel {
    GetCommentsModel({
        required this.postIdScommenters,
    });

    List<PostIdScommenter> postIdScommenters;

    factory GetCommentsModel.fromJson(Map<String, dynamic> json) => GetCommentsModel(
        postIdScommenters: List<PostIdScommenter>.from(json["postId'scommenters"].map((x) => PostIdScommenter.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "postId'scommenters": List<dynamic>.from(postIdScommenters.map((x) => x.toJson())),
    };
}

class PostIdScommenter {
    PostIdScommenter({
        required this.id,
        required this.author,
        required this.text,
        required this.postedOn,
    });

    int id;
    String author;
    String text;
    DateTime postedOn;

    factory PostIdScommenter.fromJson(Map<String, dynamic> json) => PostIdScommenter(
        id: json["id"],
        author: json["author"],
        text: json["text"],
        postedOn: DateTime.parse(json["posted_on"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "text": text,
        "posted_on": postedOn.toIso8601String(),
    };
}
