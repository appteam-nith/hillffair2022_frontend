
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.firstName,
        required this.lastName,
        required this.firebase,
        required this.name,
        required this.phone,
        required this.chatAllowed,
        required this.chatReports,
        required this.email,
        required this.score,
        required this.instagramId,
        required this.profileImage,
    });

    String firstName;
    String lastName;
    String firebase;
    String name;
    String phone;
    bool chatAllowed;
    int chatReports;
    String email;
    int score;
    String instagramId;
    String profileImage;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        firebase: json["firebase"],
        name: json["name"],
        phone: json["phone"],
        chatAllowed: json["ChatAllowed"],
        chatReports: json["ChatReports"],
        email: json["email"],
        score: json["score"],
        instagramId: json["instagramId"],
        profileImage: json["profileImage"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "firebase": firebase,
        "name": name,
        "phone": phone,
        "ChatAllowed": chatAllowed,
        "ChatReports": chatReports,
        "email": email,
        "score": score,
        "instagramId": instagramId,
        "profileImage": profileImage,
    };
}