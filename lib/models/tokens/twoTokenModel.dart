// To parse this JSON data, do
//
//     final tokensModel = tokensModelFromJson(jsonString);

import 'dart:convert';

TokensModel tokensModelFromJson(String str) => TokensModel.fromJson(json.decode(str));

String tokensModelToJson(TokensModel data) => json.encode(data.toJson());

class TokensModel {
    TokensModel({
        required this.refresh,
        required this.access,
    });

    String refresh;
    String access;

    factory TokensModel.fromJson(Map<String, dynamic> json) => TokensModel(
        refresh: json["refresh"],
        access: json["access"],
    );

    Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
    };
}
