// To parse this JSON data, do
//
//     final PostImgModel = PostImgModelFromJson(jsonString);

import 'dart:convert';


String postImgModelToJson(PostImgModel data) => json.encode(data.toJson());

class PostImgModel {
    PostImgModel({
        required this.photo,
        required this.text,

    });

    
    
    String photo;
    String text;

    factory PostImgModel.fromJson(Map<String, dynamic> json) => PostImgModel(
        
        photo: json["photo"] ?? "http://res.cloudinary.com/dfinmhios/image/upload/v1649642869/wbiob4xouvpkbvclo0iw.jpg",
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        
        "photo": photo == null ? null : photo,
        "text": text,
    };
}






