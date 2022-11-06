import 'dart:developer';
import 'dart:io';

import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/models/userFeed/newFeedModel.dart';
import 'package:hillfair2022_frontend/models/userFeed/user_feed_model.dart';
import 'package:http/http.dart' as http;

import '../../utils/api_constants.dart';

class UserFeedServices {
  static int istNull = 0;
  static Future<Object> getUserFeed(String? nxtUrl, String? prevUrl) async {
    
    try {
      var url;
      
      if (prevUrl == null && nxtUrl == null && istNull ==0) {
        istNull=1;
        url = Uri.parse(userFeedUrl);
      } else if (prevUrl == null && nxtUrl == null && istNull ==1) {
        return Success(
            code: 002,
            response: newUserFeedModelFromJson(
                "{'count': 2,'next': null,'previous': null,'results': []}"));
      } else {
        url = nxtUrl;
      }

      // var url = Uri.parse(userFeedUrl);
      var response = await http.get(url);

      if (200 == response.statusCode) {
        print(response.statusCode);
        print("feed data fetched");
        return Success(
            code: getSuccessCode,
            response: newUserFeedModelFromJson(response.body));
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
