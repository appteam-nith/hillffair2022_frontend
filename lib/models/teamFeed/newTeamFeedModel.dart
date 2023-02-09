import 'dart:convert';
import 'package:hillfair2022_frontend/models/teamFeed/teamFeed_model.dart';


NewTeamFeedModel newTeamFeedModelFromJson(String str) =>
    NewTeamFeedModel.fromJson(json.decode(str));

String newTeamFeedModelToJson(NewTeamFeedModel data) =>
    json.encode(data.toJson());

class NewTeamFeedModel {
  NewTeamFeedModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<TeamFeedModel> results;

  factory NewTeamFeedModel.fromJson(Map<String, dynamic> json) =>
      NewTeamFeedModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<TeamFeedModel>.from(json["results"].map((x) => TeamFeedModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
