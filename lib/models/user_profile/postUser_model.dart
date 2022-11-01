// To parse this JSON data, do
//
//     final postUserModel = postUserModelFromJson(jsonString);

import 'dart:convert';

PostUserModel postUserModelFromJson(String str) => PostUserModel.fromJson(json.decode(str));

String postUserModelToJson(PostUserModel data) => json.encode(data.toJson());

class PostUserModel {
    PostUserModel({
        required this.password,
        required this.firstName,
        required this.lastName,
        required this.firebase,
        required this.name,
        required this.gender,
        required this.phone,
        required this.chatAllowed,
        required this.chatReports,
        required this.email,
        required this.score,
        required this.instagramId,
        required this.profileImage,
    });

    String password;
    String firstName;
    String lastName;
    String firebase;
    String name;
    String gender;
    String phone;
    bool chatAllowed;
    int chatReports;
    String email;
    int score;
    String instagramId;
    String profileImage;

    factory PostUserModel.fromJson(Map<String, dynamic> json) => PostUserModel(
        password: json["password"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        firebase: json["firebase"],
        name: json["name"],
        gender: json["gender"],
        phone: json["phone"],
        chatAllowed: json["ChatAllowed"],
        chatReports: json["ChatReports"],
        email: json["email"],
        score: json["score"],
        instagramId: json["instagramId"],
        profileImage: json["profileImage"],
    );

    Map<String, dynamic> toJson() => {
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
        "firebase": firebase,
        "name": name,
        "gender": gender,
        "phone": phone,
        "ChatAllowed": chatAllowed,
        "ChatReports": chatReports,
        "email": email,
        "score": score,
        "instagramId": instagramId,
        "profileImage": profileImage,
    };
}
