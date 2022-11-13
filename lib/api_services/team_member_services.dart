import 'dart:developer';
import 'dart:io';

import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/models/teams/newTeam_members_model.dart';
import 'package:http/http.dart' as http;
import '../models/teams/team_member_model.dart';
import '../models/tokens/accTokenModel.dart';
import '../utils/api_constants.dart';
import '../utils/global.dart';

class TeamMemberService {
  static Future<Object> getTeamMembers() async {
    try {
      var acTokenUrl = Uri.parse(accessTokenUrl);
      Map<String, String> accessBody = {"refresh": Globals.authToken};
      var accessTokenRes = await http.post(acTokenUrl, body: accessBody);
      AccessTokenModel accessToken = accessTokenModelFromJson(accessTokenRes.body);

      //Authorization header
      Map<String, String> header = {'Authorization': "Bearer ${accessToken.access}",'content-type': 'application/json'};

      var url = Uri.parse(teamMembersUrl);
      var response = await http.get(url, headers: header);
      if (getSuccessCode == response.statusCode) {
        return Success(
            code: getSuccessCode, response: newTeamMemberModelFromJson(response.body));
      }

      return Failure(code: invalidResponse, errorMessage: 'Invalid Response');
    } on HttpException {
      return Failure(code: noInternet, errorMessage: 'No Internet');
    } on FormatException {
      return Failure(code: invalidFormat, errorMessage: 'Invalid Format');
    } catch (e) {
      return Failure(code: unknownError, errorMessage: e.toString());
    }
  }
}
