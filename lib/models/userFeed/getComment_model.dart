// To parse this JSON data, do
//
//     final getCommentsModel = getCommentsModelFromJson(jsonString);

import 'dart:convert';

GetCommentsModel getCommentsModelFromJson(String str, String postId) => GetCommentsModel.fromJson(json.decode(str), postId
);

String getCommentsModelToJson(GetCommentsModel data, String postId) => json.encode(data.toJson(postId));

class GetCommentsModel {
    GetCommentsModel({
        required this.postIdScommenters,
    });

    List<PostIdScommenter> postIdScommenters;

    factory GetCommentsModel.fromJson(Map<String, dynamic> json, String postId) => GetCommentsModel(
        postIdScommenters: List<PostIdScommenter>.from(json["$postId'scommenters"].map((x) => PostIdScommenter.fromJson(x))),
    );

    Map<String, dynamic> toJson(String postId) => {
        "$postId'scommenters": List<dynamic>.from(postIdScommenters.map((x) => x.toJson())),
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
