// To parse this JSON data, do
//
//     final getLIkerModel = getLIkerModelFromJson(jsonString);

import 'dart:convert';

GetLIkerModel getLIkerModelFromJson(String str) => GetLIkerModel.fromJson(json.decode(str));

String getLIkerModelToJson(GetLIkerModel data) => json.encode(data.toJson());

class GetLIkerModel {
    GetLIkerModel({
        required this.count,
        this.next,
        this.previous,
        required this.results,
    });

    int count;
    dynamic next;
    dynamic previous;
    List<Result> results;

    factory GetLIkerModel.fromJson(Map<String, dynamic> json) => GetLIkerModel(
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
