import 'dart:io';

import 'package:hillfair2022_frontend/api_services/auth_services.dart';

import '../../models/userFeed/getComment_model.dart';
import '../../utils/api_constants.dart';
import '../api_status.dart';
import 'package:http/http.dart' as http;

class GetComentsServices {
  static Future<Object> getComments(String postId) async {
    try {
      Map<String, String> header =await AuthServices.getAuthHeader();
      var url = Uri.parse("$getCommentUrl/$postId/");
      var response = await http.get(url, headers: header);
      if (getSuccessCode == response.statusCode) {
        print("commmemt fetched.$postId");
        return Success(
            code: getSuccessCode,
            response: getCommentsModelFromJson(response.body, postId));
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
