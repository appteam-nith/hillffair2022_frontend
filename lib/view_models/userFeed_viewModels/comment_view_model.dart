import 'package:flutter/cupertino.dart';
import 'package:hillfair2022_frontend/api_services/userFeedServicies/comment_services.dart';

class PostCommentViewModel extends ChangeNotifier {
  bool loading = false;
  bool isBack = false;
  postComment(String comment, String postid, String fbid) async {
    loading = true;
    notifyListeners();
    print("klsf");
    print(comment);
    print(postid);
    print(fbid);
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
