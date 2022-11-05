// To parse this JSON data, do
//
//     final newEventsModel = newEventsModelFromJson(jsonString);

import 'dart:convert';

import 'package:hillfair2022_frontend/models/events/event_model.dart';

NewEventsModel newEventsModelFromJson(String str) =>
    NewEventsModel.fromJson(json.decode(str));

String newEventsModelToJson(NewEventsModel data) => json.encode(data.toJson());

class NewEventsModel {
  NewEventsModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<EventModel> results;

  factory NewEventsModel.fromJson(Map<String, dynamic> json) => NewEventsModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<EventModel>.from(
            json["results"].map((x) => EventModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
