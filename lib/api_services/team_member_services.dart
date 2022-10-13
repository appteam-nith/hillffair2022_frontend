import 'dart:developer';
import 'dart:io';

import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:http/http.dart' as http;
import '../models/team_member_model.dart';
import '../utils/api_constants.dart';

class TeamMemberServices {
  String id = "723aca26-833c-4698-9542-eb379370b983";

  TeamMemberServices(String id) {
    this.id;
  }

  static Future<Object> getTeamMembers(String id) async {
    try {
      var url = Uri.parse("$teamMembersUrl?id=$id/");
      var response = await http.get(url);
      if (200 == response.statusCode) {
        return Success(
            code: getSuccessCode,
            response: teamMemberModelFromJson(response.body));
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
