import 'package:flutter/cupertino.dart';
import 'package:hillfair2022_frontend/api_services/comment_services.dart';
import 'package:hillfair2022_frontend/api_services/post_img_service.dart';
import 'package:hillfair2022_frontend/models/comment_model.dart';

import '../models/post_img_model.dart';
import 'package:http/http.dart' as http;

class CommentViewModel extends ChangeNotifier {
  bool loading = false;
  bool isBack = false;
  postComment(CommentModel data, String postid, String fbid) async {
    loading = true;
    notifyListeners();
    var response = (await CommentServicie.postComment(data, postid, fbid))!;
    if (response.statusCode == 201) {
      isBack = true;
    }
    loading = false;
    notifyListeners();
  }
}
