// To parse this JSON data, do
//
//     final getLIkerModel = getTeamFeedLikeFromJson(jsonString);

import 'dart:convert';

TeamFeedLikeModel getTeamFeedLikeFromJson(String str) => TeamFeedLikeModel.fromJson(json.decode(str));

String getTeamFeedLikeToJson(TeamFeedLikeModel data) => json.encode(data.toJson());

class TeamFeedLikeModel {
    TeamFeedLikeModel({
        required this.count,
        this.next,
        this.previous,
        required this.results,
    });

    int count;
    dynamic next;
    dynamic previous;
    List<Result> results;

    factory TeamFeedLikeModel.fromJson(Map<String, dynamic> json) => TeamFeedLikeModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        required this.firebase,
    });

    String firebase;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        firebase: json["firebase"],
    );

    Map<String, dynamic> toJson() => {
        "firebase": firebase,
    };
}
