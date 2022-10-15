import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/models/error_model.dart';

import '../../api_services/api_status.dart';
import '../../api_services/userFeedServicies/comment_services.dart';
import '../../api_services/userFeedServicies/getComments_services.dart';
import '../../models/userFeed/getComment_model.dart';


class GetCommentsViewModel extends ChangeNotifier {

  bool _loading = false;
  late GetCommentsModel _commentsList;
  ErrorModel _getCommentsError = ErrorModel(000, " error not set");

  bool get loading => _loading;
  GetCommentsModel get commentsList => _commentsList;
  ErrorModel get getCommentsError => _getCommentsError;

  setLoading(bool loading) async {
    _loading = loading;
    // notifyListeners();
  }

  setCommentsList(GetCommentsModel commentsList) {
    _commentsList = commentsList;
  }

  setGetCommentsError(ErrorModel getCommentsError) {
    _getCommentsError = getCommentsError;
  }

  getComments(String postId) async {
    setLoading(true);
    var response = await GetComentsServices.getComments(postId);
    if (response is Success) {
      setCommentsList(response.response as GetCommentsModel);
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
