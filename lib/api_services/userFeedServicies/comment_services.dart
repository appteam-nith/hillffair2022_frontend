import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/models/userFeed/getComment_model.dart';
import 'package:http/http.dart' as http;

import '../../models/events/event_model.dart';
import '../../models/userFeed/post_img_model.dart';
import '../../utils/api_constants.dart';

class CommentServicie {
  static Future<http.Response?> postComment(
      String comment, String postId, String fbId) async {
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
      print(e.toString());
    }
    return response;
  }
}
