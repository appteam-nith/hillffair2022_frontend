import 'dart:developer';
import 'dart:io';

import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/models/user_model.dart';
import 'package:http/http.dart' as http;

import '../models/checkUser_model.dart';
import '../models/event_model.dart';
import '../models/post_img_model.dart';
import '../utils/api_constants.dart';

class UserServices {
  static Uri? get url => null;

  static Future<http.Response?> postUser(UserModel data) async {
    http.Response? response;
    try {
      var url = Uri.parse(userUrl);
      response = await http.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: userModelToJson(data));
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  static Future<Object> getUsers() async {
    try {
      var url = Uri.parse(userUrl);
      var response = await http.get(url);
      if (200 == response.statusCode) {
        return Success(
            code: successCode, response: userModelFromJson(response.body));
      }

      return Failure(code: invalidResponse, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: noInternet, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: invalidFormat, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: unknownError, errorResponse: e.toString());
    }
  }

  static Future<Object> checkUser(String email) async {
    try {
      //var url = Uri.parse(checkUserUrl);
      var response = await http.get(url!);
      if (200 == response.statusCode) {
        return Success(
            code: successCode, response: checkUserModelFromJson(response.body));
      }

      return Failure(code: invalidResponse, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: noInternet, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: invalidFormat, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: unknownError, errorResponse: e.toString());
    }
  }

  
}