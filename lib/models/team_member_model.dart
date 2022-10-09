// To parse this JSON data, do
//
//     final teamMemberModel = teamMemberModelFromJson(jsonString);

import 'dart:convert';

List<TeamMemberModel> teamMemberModelFromJson(String str) => List<TeamMemberModel>.from(json.decode(str).map((x) => TeamMemberModel.fromJson(x)));

String teamMemberModelToJson(List<TeamMemberModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamMemberModel {
    TeamMemberModel({
        required this.id,
        required this.name,
        required this.teamName,
        required this.position,
        required this.image,
    });

    int id;
    String name;
    int teamName;
    String position;
    String image;

    factory TeamMemberModel.fromJson(Map<String, dynamic> json) => TeamMemberModel(
        id: json["id"],
        name: json["name"],
        teamName: json["team_name"],
        position: json["position"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "team_name": teamName,
        "position": position,
        "image": image,
    };
}
