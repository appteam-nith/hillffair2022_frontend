// To parse this JSON data, do
//
//     final getChatRoomModel = getChatRoomModelFromJson(jsonString);

import 'dart:convert';

GetChatRoomModel getChatRoomModelFromJson(String str) => GetChatRoomModel.fromJson(json.decode(str));

String getChatRoomModelToJson(GetChatRoomModel data) => json.encode(data.toJson());

class GetChatRoomModel {
    GetChatRoomModel({
        required this.roomId,
        required this.nickname1,
        required this.nickname2,
        required this.roomBlocked,
        required this.chater1,
        required this.chater2,
    });

    String roomId;
    String nickname1;
    String nickname2;
    bool roomBlocked;
    String chater1;
    String chater2;

    factory GetChatRoomModel.fromJson(Map<String, dynamic> json) => GetChatRoomModel(
        roomId: json["id"],
        nickname1: json["nickname1"],
        nickname2: json["nickname2"],
        roomBlocked: json["roomBlocked"],
        chater1: json["chater1"],
        chater2: json["chater2"],
    );

    Map<String, dynamic> toJson() => {
        "id": roomId,
        "nickname1": nickname1,
        "nickname2": nickname2,
        "roomBlocked": roomBlocked,
        "chater1": chater1,
        "chater2": chater2,
    };
}
