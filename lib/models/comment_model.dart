// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
    CommentModel({
        required this.text,
    });

    String text;

    factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
    };
}
