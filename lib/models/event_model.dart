// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

List<EventModel> eventModelFromJson(String str) =>
    List<EventModel>.from(json.decode(str).map((x) => EventModel.fromJson(x)));

String eventModelToJson(List<EventModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class EventModel {
  EventModel({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.clubName,
    required this.platform,
    required this.image,
    required this.regUrl,
    required this.type,
  });

  String title;
  String description;
  DateTime startTime;
  DateTime endTime;
  String clubName;
  String platform;
  String image;
  String regUrl;
  int type;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        title: json["title"],
        description: json["description"],
        startTime: json["endTime"] == null
            ? DateTime(0000, 00, 0)
            : DateTime.parse(json["startTime"]),
        endTime: json["endTime"] == null
            ? DateTime(0000, 00, 0)
            : DateTime.parse(json["endTime"]),
        clubName: json["clubName"],
        platform: json["platform"],
        image: json["image"],
        regUrl: json["regURL"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "startTime": startTime == null
            ? DateTime(0000, 00, 0)
            : startTime.toIso8601String(),
        "endTime":
            endTime == null ? DateTime(0000, 00, 0) : endTime.toIso8601String(),
        "clubName": clubName,
        "platform": platform,
        "image": image,
        "regURL": regUrl,
        "type": type,
      };

  @override
  String toString() {
    return 'EventModel{title: $title, description: $description, startTime: $startTime, endTime: $endTime, clubName: $clubName, platform: $platform, image: $image, regUrl: $regUrl, type: $type}';
  }
}
