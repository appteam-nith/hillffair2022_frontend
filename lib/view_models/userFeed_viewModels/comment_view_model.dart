import 'package:flutter/cupertino.dart';
import 'package:hillfair2022_frontend/api_services/userFeedServicies/comment_services.dart';
import 'package:hillfair2022_frontend/api_services/userFeedServicies/post_userFeed_servicies.dart';
import 'package:hillfair2022_frontend/models/userFeed/getComment_model.dart';

import '../../api_services/api_status.dart';
import '../../models/error_model.dart';
import '../../models/userFeed/post_img_model.dart';
import 'package:http/http.dart' as http;

class PostCommentViewModel extends ChangeNotifier {
  bool loading = false;
  bool isBack = false;
  postComment(String comment, String postid, String fbid) async {
    loading = true;
    notifyListeners();
    var response = (await CommentServicie.postComment(comment, postid, fbid))!;
    if (response.statusCode == 201) {
      isBack = true;
      print("comment posted");
    } else {
      print("not not posted");
    }
    loading = false;
    notifyListeners();
  }
}
