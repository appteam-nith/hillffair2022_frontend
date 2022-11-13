import 'dart:io';

import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/utils/snackbar.dart';
import 'package:http/http.dart' as http;

import '../../utils/api_constants.dart';
import '../auth_services.dart';

class PostLikeService {
  static Future<Object> postLike(String postId, String fbId) async {
    http.Response? response;
    try {
      Map<String, String> header =await AuthServices.getAuthHeader();
      var url = Uri.parse("$postLikeUrl/$postId/$fbId");
      response = await http.post(url, headers: header);
      print(response.statusCode);
      if (response.statusCode == postSuccessCode) {
        return Success(code: postSuccessCode, response: response.body);
      }
      return Failure(code: invalidResponse, errorMessage: 'Invalid Response');
    } on HttpException {
      return Failure(code: noInternet, errorMessage: 'No Internet');
    } on FormatException {
      return Failure(code: invalidFormat, errorMessage: 'Invalid Format');
    } catch (e) {
      print(e.toString());
      return Failure(code: unknownError, errorMessage: e.toString());
    }
  }
}
