import 'dart:developer';
import 'dart:io';

import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/models/teamFeed/teamFeed_model.dart';
import 'package:http/http.dart' as http;

import '../../utils/api_constants.dart';

class TeamFeedList {
  static Future<Object> getTeamFeed() async {
    try {
      var url = Uri.parse("https://hillffair2k22.herokuapp.com/TeamFeed/");
      var response = await http.get(url);
      if (200 == response.statusCode) {
        print(response.statusCode);
        print("Team feed data fetched");
        return Success(
            code: getSuccessCode,
            response: teamFeedModelFromJson(response.body));
      }

      return Failure(code: invalidResponse, errorMessage: 'Invalid Response');
    } on HttpException {
      return Failure(code: noInternet, errorMessage: 'No Internet');
    } on FormatException {
      return Failure(code: invalidFormat, errorMessage: 'Invalid Format');
    } catch (e) {
      print("feed data not-fetched");
      return Failure(code: unknownError, errorMessage: e.toString());
    }
  }
}
