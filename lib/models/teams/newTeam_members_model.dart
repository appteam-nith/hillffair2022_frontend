// To parse this JSON data, do
//
//     final newTeamMemberModel = newTeamMemberModelFromJson(jsonString);

import 'dart:convert';

import 'package:hillfair2022_frontend/models/teams/team_member_model.dart';

NewTeamMemberModel newTeamMemberModelFromJson(String str) =>
    NewTeamMemberModel.fromJson(json.decode(str));

String newTeamMemberModelToJson(NewTeamMemberModel data) =>
    json.encode(data.toJson());

class NewTeamMemberModel {
  NewTeamMemberModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<TeamMemberModel> results;

  factory NewTeamMemberModel.fromJson(Map<String, dynamic> json) =>
      NewTeamMemberModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<TeamMemberModel>.from(
            json["results"].map((x) => TeamMemberModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
