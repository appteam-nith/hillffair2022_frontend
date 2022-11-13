// To parse this JSON data, do
//
//     final accessTokenModel = accessTokenModelFromJson(jsonString);

import 'dart:convert';

AccessTokenModel accessTokenModelFromJson(String str) => AccessTokenModel.fromJson(json.decode(str));

String accessTokenModelToJson(AccessTokenModel data) => json.encode(data.toJson());

class AccessTokenModel {
    AccessTokenModel({
        required this.access,
    });

    String access;

    factory AccessTokenModel.fromJson(Map<String, dynamic> json) => AccessTokenModel(
        access: json["access"],
    );

    Map<String, dynamic> toJson() => {
        "access": access,
    };
}
