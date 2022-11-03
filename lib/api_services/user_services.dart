import 'dart:developer';
import 'dart:io';

import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:http/http.dart' as http;

import '../models/user_profile/checkUser_model.dart';
import '../models/events/event_model.dart';
import '../models/userFeed/post_img_model.dart';
import '../models/user_profile/user_model.dart';
import '../utils/api_constants.dart';

class UserServices {
   Future<Object> postUser(UserModel data) async {
    http.Response? response;
    try {
      var url = Uri.parse(postUserUrl);
      response = await http.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: userModelToJson(data));
      if (response.statusCode == 201) {
        print(response.statusCode);
        print("userPosted");
        return Success(
            code: response.statusCode,
            response: userModelFromJson(response.body));
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

  static Future<Object> getUsers() async {
    try {
      var url = Uri.parse(postUserUrl);
      var response = await http.get(url);
      if (200 == response.statusCode) {
        return Success(
            code: getSuccessCode, response: userModelFromJson(response.body));
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

  static Future<Object> checkUser(String email) async {
    try {
      var url = Uri.parse("$checkUserUrl$email");
      var response = await http.get(url);
      if (200 == response.statusCode) {
        return Success(
            code: getSuccessCode,
            response: checkUserModelFromJson(response.body));
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

  static Future<http.Response?> editUser(UserModel data, String fbId) async {
    http.Response? response;
    try {
      var url = Uri.parse("$postUserUrl$fbId/");
      response = await http.put(url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: userModelToJson(data));
    } catch (e) {
      log(e.toString());
    }
    return response;
  }
}
