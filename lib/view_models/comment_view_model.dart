import 'package:flutter/cupertino.dart';
import 'package:hillfair2022_frontend/api_services/userFeedServicies/comment_services.dart';
import 'package:hillfair2022_frontend/api_services/userFeedServicies/post_userFeed_servicies.dart';
import 'package:hillfair2022_frontend/models/userFeed/comment_model.dart';

import '../models/userFeed/post_img_model.dart';
import 'package:http/http.dart' as http;

class CommentViewModel extends ChangeNotifier {
  bool loading = false;
  bool isBack = false;
  postComment(String comment, String postid, String fbid) async {
    loading = true;
    notifyListeners();
    var response = (await CommentServicie.postComment(comment, postid, fbid))!;
    if (response.statusCode == 201) {
      isBack = true;
    }
    loading = false;
    notifyListeners();
  }
}
