// To parse this JSON data, do
//
//     final checkUserModel = checkUserModelFromJson(jsonString);

import 'dart:convert';

CheckUserModel checkUserModelFromJson(String str) => CheckUserModel.fromJson(json.decode(str));

String checkUserModelToJson(CheckUserModel data) => json.encode(data.toJson());

class CheckUserModel {
    CheckUserModel({
        required this.userPresent,
    });

    bool userPresent;

    factory CheckUserModel.fromJson(Map<String, dynamic> json) => CheckUserModel(
        userPresent: json["user_present"],
    );

    Map<String, dynamic> toJson() => {
        "user_present": userPresent,
    };
}
