// To parse this JSON data, do
//
//     final getChatMessagesModel = getChatMessagesModelFromJson(jsonString);

import 'dart:convert';

GetChatMessagesModel getChatMessagesModelFromJson(String str) => GetChatMessagesModel.fromJson(json.decode(str));

String getChatMessagesModelToJson(GetChatMessagesModel data) => json.encode(data.toJson());

class GetChatMessagesModel {
    GetChatMessagesModel({
        required this.messages,
    });

    List<Message> messages;

    factory GetChatMessagesModel.fromJson(Map<String, dynamic> json) => GetChatMessagesModel(
        messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
    };
}

class Message {
    Message({
        required this.id,
        required this.value,
        required this.date,
        required this.senderId,
        required this.roomId,
    });

    int id;
    String value;
    DateTime date;
    String senderId;
    String roomId;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        value: json["value"],
        date: DateTime.parse(json["date"]),
        senderId: json["sender_id"],
        roomId: json["room_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "date": date.toIso8601String(),
        "sender_id": senderId,
        "room_id": roomId,
    };
}
