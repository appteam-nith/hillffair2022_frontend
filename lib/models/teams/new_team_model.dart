// To parse this JSON data, do
//
//     final newTeamsModel = newTeamsModelFromJson(jsonString);

import 'dart:convert';

import 'package:hillfair2022_frontend/models/teams/team_model.dart';

NewTeamsModel newTeamsModelFromJson(String str) =>
    NewTeamsModel.fromJson(json.decode(str));

String newTeamsModelToJson(NewTeamsModel data) => json.encode(data.toJson());

class NewTeamsModel {
  NewTeamsModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<TeamModel> results;

  factory NewTeamsModel.fromJson(Map<String, dynamic> json) => NewTeamsModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<TeamModel>.from(
            json["results"].map((x) => TeamModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
