import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/models/userFeed/comment_model.dart';
import 'package:http/http.dart' as http;

import '../../models/event_model.dart';
import '../../models/userFeed/post_img_model.dart';
import '../../utils/api_constants.dart';

class CommentServicie {

  static Future<http.Response?> postComment(String comment, String postId, String fbId) async {
    http.Response? response;
    try {
      var url = Uri.parse("$postCommentUrl$postId/$fbId/");
      response = await http.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: jsonEncode(<String, String>{
          'text': comment,
        }));
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  static Future<Object> getComments(String postId) async {
    try {
      var url = Uri.parse("$getCommentUrl/$postId/");
      var response = await http.get(url);
      if (getSuccessCode == response.statusCode) {
        return Success(
            code: getSuccessCode, response: getCommentsModelFromJson(response.body));
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
