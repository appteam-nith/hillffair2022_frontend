import 'dart:developer';
import 'dart:io';

import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:http/http.dart' as http;

import '../models/event_model.dart';
import '../models/post_img_model.dart';
import '../utils/api_constants.dart';

class PostImgServices {

  static Future<http.Response?> postImgS(PostImgModel data, String id) async {
    http.Response? response;
    try {
      var url = Uri.parse("$postImgUrl$id/");
      response = await http.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: postImgModelToJson(data));
    } catch (e) {
      log(e.toString());
    }
    return response;
  }
}
