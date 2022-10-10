import 'dart:developer';
import 'dart:io';

import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/models/comment_model.dart';
import 'package:http/http.dart' as http;

import '../models/event_model.dart';
import '../models/post_img_model.dart';
import '../utils/api_constants.dart';

class CommentServicie {

  static Future<http.Response?> postComment(CommentModel data, String postId, String fbId) async {
    http.Response? response;
    try {
      var url = Uri.parse("$commentUrl$postId/$fbId/");
      response = await http.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: commentModelToJson(data));
    } catch (e) {
      log(e.toString());
    }
    return response;
  }
}
