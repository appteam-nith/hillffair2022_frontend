import 'dart:developer';
import 'dart:io';

import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/utils/snackbar.dart';
import 'package:http/http.dart' as http;

import '../../models/events/event_model.dart';
import '../../models/userFeed/post_img_model.dart';
import '../../utils/api_constants.dart';
import '../auth_services.dart';

class PostImgServices {
  static Future<http.Response?> postImg(PostImgModel data, String fbId) async {
    http.Response? response;
    try {
      Map<String, String> header =await AuthServices.getAuthHeader();
      var url = Uri.parse("$postImgUrl$fbId/");
      response = await http.post(url,
          headers: header,
          body: postImgModelToJson(data));
      if (response.statusCode == 201) {
        print("feed posted");
      } else {
        // Utils.showSnackBar(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return response;
  }
}
