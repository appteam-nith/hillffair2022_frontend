import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/models/error_model.dart';
import '../../api_services/api_status.dart';
import '../../api_services/userFeedServicies/userFeed_services.dart';
import '../../models/userFeed/user_feed_model.dart';

class UserFeedViewModel extends ChangeNotifier {
  UserFeedViewModel() {
    getUserFeed();
  }

  bool _loading = false;
  List<UserFeedModel> _userFeedListModel = [];
  ErrorModel _userFeedError = ErrorModel(000, " error not set");

  bool get loading => _loading;
  List<UserFeedModel> get userFeedListModel => _userFeedListModel;
  ErrorModel get userFeedError => _userFeedError;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserFeedListModel(List<UserFeedModel> userFeedListModel) {
    _userFeedListModel = userFeedListModel;
  }

  setuserFeedError(ErrorModel userFeedError) {
    _userFeedError = userFeedError;
  }

  getUserFeed() async {
    setLoading(true);
    var response = await UserFeedServices.getUserFeed();
    if (response is Success) {
      setUserFeedListModel(response.response as List<UserFeedModel>);
      log(response.response.toString());
    }
    if (response is Failure) {
      ErrorModel userFeedError = ErrorModel(
        response.code,
        response.errorMessage,
      );
      setuserFeedError(userFeedError);
    }
    setLoading(false);
  }
}
