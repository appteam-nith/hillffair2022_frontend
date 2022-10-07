import 'dart:io';

import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:http/http.dart' as http;

import '../models/event_model.dart';
import '../utils/api_constants.dart';

class EventServices {
  static Future<Object> getEvents() async {
    try {
      var url = Uri.parse(eventUrl);
      var response = await http.get(url);
      if (200 == response.statusCode) {
        return Success(
            code: successCode, response: eventModelFromJson(response.body));
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
