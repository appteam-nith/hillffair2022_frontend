import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/models/error_model.dart';
import '../../api_services/api_status.dart';
import '../../api_services/userFeedServicies/getComments_services.dart';
import '../../models/userFeed/getComment_model.dart';


class GetCommentsViewModel extends ChangeNotifier {

  bool _loading = false;
  late GetCommentsModel _commentbody;
  ErrorModel _getCommentsError = ErrorModel(000, " error not set");

  bool get loading => _loading;
  GetCommentsModel get commentbody => _commentbody;
  ErrorModel get getCommentsError => _getCommentsError;

  setLoading(bool loading) async {
    _loading = loading;
    // notifyListeners();
  }

  setCommentBody(GetCommentsModel commentbody) {
    _commentbody = commentbody;
  }

  setGetCommentsError(ErrorModel getCommentsError) {
    _getCommentsError = getCommentsError;
  }

  getComments(String postId) async {
    setLoading(true);
    var response = await GetComentsServices.getComments(postId);
    if (response is Success) {
      setCommentBody(response.response as GetCommentsModel);
    }
    if (response is Failure) {
      ErrorModel getCommentsError = ErrorModel(
        response.code,
        response.errorMessage,
      );
      setGetCommentsError(getCommentsError);
    }
    setLoading(false);
  }
}
