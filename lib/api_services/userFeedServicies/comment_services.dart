import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../utils/api_constants.dart';
import '../auth_services.dart';

class CommentServicie {
  static Future<http.Response?> postComment(
      String comment, String postId, String fbId) async {
    http.Response? response;
    try {
      Map<String, String> header =await AuthServices.getAuthHeader();
      var url = Uri.parse("$postCommentUrl$postId/$fbId/");
      response = await http.post(url,
          headers: header,
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
