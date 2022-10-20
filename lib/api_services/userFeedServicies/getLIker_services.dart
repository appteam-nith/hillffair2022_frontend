import 'dart:io';

import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/models/userFeed/get_liker_model.dart';
import 'package:http/http.dart' as http;

import '../../utils/api_constants.dart';

class GetLikerServices{
  static Future<Object> getLikers(String postId)async{
     http.Response? response;
     try {
      var url = Uri.parse("$getLikerUrl$postId/");
      response = await http.get(url);
      if (response.statusCode == getSuccessCode  ) {
        return Success(code: getSuccessCode, response: getLIkerModelFromJson(response.body));
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