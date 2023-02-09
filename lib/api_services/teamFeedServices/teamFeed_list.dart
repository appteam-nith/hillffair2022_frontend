import 'dart:io';
import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:http/http.dart' as http;
import '../../models/teamFeed/newTeamFeedModel.dart';
import '../../models/tokens/accTokenModel.dart';
import '../../utils/api_constants.dart';
import '../../utils/global.dart';

class TeamFeedList {
  static int istNull = 0;
  static Future<Object> getTeamFeed(String? nxtUrl, String? prevUrl) async {
    try {
        var url;

      if (prevUrl == null && nxtUrl == null && istNull == 0) {
        istNull = 1;
        url = Uri.parse("${teamFeedUrl}/${Globals.presentUser.firebase}/");
      } else if (prevUrl == null && nxtUrl == null && istNull == 1) {
        return Success(
            code: 002,
            response: newTeamFeedModelFromJson(
                "{'count': 2,'next': null,'previous': null,'results': []}"));
      } else if(prevUrl == "prevUrl" && nxtUrl == "nxtUrl"){
          url = Uri.parse("${teamFeedUrl}/${Globals.presentUser.firebase}/");
      }else {
        url = Uri.parse(nxtUrl!);
      }

      var acTokenUrl = Uri.parse(accessTokenUrl);
      Map<String, String> accessBody = {"refresh": Globals.authToken};
      var accessTokenRes = await http.post(acTokenUrl, body: accessBody);
      AccessTokenModel accessToken = accessTokenModelFromJson(accessTokenRes.body);

      //Authorization header
      Map<String, String> header = {'Authorization': "Bearer ${accessToken.access}",'content-type': 'application/json'};

      // var url = Uri.parse(teamFeedUrl);
      var response = await http.get(url, headers: header);
      if (200 == response.statusCode) {
        print(response.statusCode);
        print("Team feed data fetched");
        return Success(
            code: getSuccessCode,
            response: newTeamFeedModelFromJson(response.body));
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
