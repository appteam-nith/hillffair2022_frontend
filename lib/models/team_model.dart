// To parse this JSON data, do
//
//     final teamModel = teamModelFromJson(jsonString);

import 'dart:convert';

List<TeamModel> teamModelFromJson(String str) => List<TeamModel>.from(json.decode(str).map((x) => TeamModel.fromJson(x)));

String teamModelToJson(List<TeamModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamModel {
    TeamModel({
        required this.id,
        required this.clubName,
        required this.image,
    });

    String id;
    String clubName;
    String image;

    factory TeamModel.fromJson(Map<String, dynamic> json) =>
        TeamModel(
            id: json["id"],
            clubName: json["club_name"],
            image: json["image"],
        );

    Map<String, dynamic> toJson() =>
        {
            "id": id,
            "club_name": clubName,
            "image": image,
        };

    @override
    String toString() {
        return 'TeamModel{id: $id,club_name: $clubName, image: $image}';
    }
}
