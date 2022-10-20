import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/api_services/userFeedServicies/post_like_services.dart';
import 'package:hillfair2022_frontend/models/error_model.dart';

import '../../api_services/api_status.dart';

class PostLIkeViewModel extends ChangeNotifier {
  bool _isLiked = false;
  bool _loading = false;
  ErrorModel _postLikeError = ErrorModel(000, " error not set");

  bool get isLiked => _isLiked;
  bool get loading => _loading;
  ErrorModel get postLikeError => _postLikeError;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setIsLiked(bool islIked) {
    _isLiked = islIked;
  }

  setPostLikeError(ErrorModel postLikeError) {
    _postLikeError = postLikeError;
  }

  postLike(String postId, String fbId) async {
    setLoading(true);
    var response = await PostLikeService.postLike(postId, fbId);
    print(postId);
    print(fbId);
    if (response is Success) {
      log(response.response.toString());
      Map<String, dynamic> likeData = jsonDecode(response.response.toString());
      setIsLiked(likeData['like']);
      print("like posted tad tada");
    }
    if (response is Failure) {
      ErrorModel postLikeError = ErrorModel(
        response.code,
        response.errorMessage,
      );
      setPostLikeError(postLikeError);
    }
    setLoading(false);
  }
}
