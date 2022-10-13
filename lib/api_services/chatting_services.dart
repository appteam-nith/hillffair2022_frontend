import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:http/http.dart' as http;

import '../models/event_model.dart';
import '../models/post_img_model.dart';
import '../utils/api_constants.dart';

class ChattingServices {
  static Future<Object> getChatRoom(String nickName, String fbId) async {
    http.Response? response;
    try {
      var url = Uri.parse("$getChatRoomUrl/$fbId/");
      response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(<String, String>{
          'nickname1': nickName,
        }),
      );
      if (postSuccessCode == response.statusCode) {
        return Success(code: postSuccessCode, response: response.body);
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