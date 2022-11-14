import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/models/error_model.dart';
import 'package:hillfair2022_frontend/models/userFeed/newFeedModel.dart';
import 'package:hillfair2022_frontend/utils/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_services/api_status.dart';
import '../../api_services/userFeedServicies/userFeed_services.dart';
import '../../models/userFeed/user_feed_model.dart';
import '../../models/user_profile/user_model.dart';
import 'getLikerViewModel.dart';

class UserFeedViewModel extends ChangeNotifier {
  UserFeedViewModel() {
    getPresentUser();
    getUserFeed();
  }
  bool isFirst = true;
  String? nxtUrl = null;
  String? prevUrl = null;
  UserModel _presentUser = UserModel(
      firstName: "firstName",
      lastName: "lastName",
      firebase: "firebase",
      name: "name",
      gender: "gender",
      phone: "phone",
      chatAllowed: true,
      chatReports: 0,
      email: "email",
      score: 0,
      instagramId: "instagramId",
      profileImage: "https://placekitten.com/250/250");

  UserModel get presentUser => _presentUser;
  setPrensentUser(UserModel presnetUser) {
    _presentUser = presnetUser;
    notifyListeners();
  }

  List<UserFeedModel> prefFeedList = [];
  bool _loading = false;
  bool _refreshLoading = false;
  List<UserFeedModel> _userFeedListModel = [];
  // List<UserFeedModel> redfeshFeedList = [];
  ErrorModel _userFeedError = ErrorModel(000, " error not set");

  bool get loading => _loading;
  bool get refreshLoading => _refreshLoading;
  List<UserFeedModel> get userFeedListModel => _userFeedListModel;
  ErrorModel get userFeedError => _userFeedError;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setRefreshLoading(_refreshLoading) async {
    _refreshLoading = _refreshLoading;
    notifyListeners();
  }

  setUserFeedListModel(List<UserFeedModel> userFeedListModel) {
    _userFeedListModel = userFeedListModel;
    notifyListeners();
  }

  setuserFeedError(ErrorModel userFeedError) {
    _userFeedError = userFeedError;
  }

  getUserFeed() async {
    if (isFirst) {
      prefFeedList = await getFeedPref();
      isFirst = false;
    } else {
      prefFeedList = userFeedListModel;
    }
    setLoading(true);
    var response = await UserFeedServices.getUserFeed(nxtUrl, prevUrl);
    if (response is Success) {
      NewUserFeedModel feed = response.response as NewUserFeedModel;
      nxtUrl = feed.next;
      setUserFeedListModel(userFeedListModel + feed.results);
      adddFeedToSahredPref(feed.results);
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

  adddFeedToSahredPref(List<UserFeedModel> feedList) async {
    SharedPreferences feedPrefs = await SharedPreferences.getInstance();
    bool isFeedStored = feedPrefs.containsKey('feedList');
    if (isFeedStored) {
      await feedPrefs.remove("feedList");
    }
    feedPrefs.setString("feedList", userFeedModelToJson(feedList));
  }

  // List<String> boolListTOStringList(List<bool> listBool) {
  //   List<String> listString = [];
  //   listBool.forEach((item) {
  //     item == true ? listString.add("true") : listString.add("false");
  //   });
  //   return listString;
  // }

  // Future<List<bool>> getIsLikedPref() async {
  //   SharedPreferences likedpref = await SharedPreferences.getInstance();
  //   List<String>? likedlist = likedpref.getStringList("isAlreadyLikedList");
  //   print("klsf");
  //   print(likedlist);
  //   if (likedlist != null) {
  //     List<bool> isAlreadyLikedList = stringListToBoolList(likedlist);
  //     return isAlreadyLikedList;
  //   }
  //   return [];
  // }

  // List<bool> stringListToBoolList(List<String> likedlist) {
  //   List<bool> boolList = [];
  //   for (var item in likedlist) {
  //     item == "true" ? boolList.add(true) : boolList.add(false);
  //   }
  //   return boolList;
  // }

  Future<List<UserFeedModel>> getFeedPref() async {
    SharedPreferences feedPrefs = await SharedPreferences.getInstance();
    String? feedJsonList = feedPrefs.getString("feedList");
    if (feedJsonList != null) {
      List<UserFeedModel> feedList = userFeedModelFromJson(feedJsonList);
      return feedList;
    }
    return [];
  }

  void getPresentUser() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    String? prseentUserJson = userPrefs.getString("presentUser");
    if (prseentUserJson!.isNotEmpty) {
      UserModel presentUser = userModelFromJson(prseentUserJson);
      setPrensentUser(presentUser);
      Globals.presentUser = presentUser;
    }
    String refreshToken = userPrefs.getString("refreshToken")!;
    Globals.authToken = refreshToken;
    // print(userPrefs.containsKey("password"));
    // print("object");
    String password = userPrefs.getString("password")!;
    Globals.password = password;
  }

  refesh() async {
    setRefreshLoading(true);
    var response = await UserFeedServices.getUserFeed("nxtUrl", "prevUrl");
    if (response is Success) {
      NewUserFeedModel feed = response.response as NewUserFeedModel;
      int diffIndex = 0;
      for (var i = 0; i < feed.results.length; i++) {
        if (feed.results[i].id == userFeedListModel[0].id) {
          diffIndex = i;
          break;
        }
      }
      var newList = feed.results.getRange(0, diffIndex).toList();
      setUserFeedListModel(newList + userFeedListModel);
      setRefreshLoading(false);
    }
    if (response is Failure) {
      ErrorModel userFeedError = ErrorModel(
        response.code,
        response.errorMessage,
      );
      setuserFeedError(userFeedError);
    }
  }
}
