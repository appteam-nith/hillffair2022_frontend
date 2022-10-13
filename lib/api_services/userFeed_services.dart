import 'dart:developer';
import 'dart:io';

import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/models/user_feed_model.dart';
import 'package:http/http.dart' as http;

import '../utils/api_constants.dart';

class UserFeedServices {
  static Future<Object> getUserFeed() async {
    try {
      var url = Uri.parse(userFeedUrl);
      var response = await http.get(url);
      if (200 == response.statusCode) {
        return Success(
            code: getSuccessCode,
            response: userFeedModelFromJson(response.body));
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
