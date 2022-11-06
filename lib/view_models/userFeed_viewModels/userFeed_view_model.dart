import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/models/error_model.dart';
import 'package:hillfair2022_frontend/models/userFeed/newFeedModel.dart';
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
  List<bool> prefIsLikedList = [];
  bool _loading = false;
  List<UserFeedModel> _userFeedListModel = [];
  List<bool> isAlreadyLikedList = [];
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
    notifyListeners();
  }

  setuserFeedError(ErrorModel userFeedError) {
    _userFeedError = userFeedError;
  }

  getUserFeed() async {
    // getPresentUser();
    prefFeedList = await getFeedPref();
    prefIsLikedList = await getIsLikedPref();
    setLoading(true);
    // prefFeedList = await getFeedPref();
    // prefIsLikedList = await getIsLikedPref();
    var response = await UserFeedServices.getUserFeed(nxtUrl, prevUrl);
    if (response is Success) {
      NewUserFeedModel feed = response.response as NewUserFeedModel;
      nxtUrl = feed.next;
      setUserFeedListModel(feed.results + userFeedListModel);
      log(response.response.toString());
      int n = feed.results.length;
      for (var i = 0; i < n; i++) {
        print("OUTER_LOOP_ONDEX${i}");
        bool isAlreadyLiked = await GetLikerViewModel()
            .getLiker(presentUser.firebase, userFeedListModel[i]);
        print("OUTER_LOOP_ONDEX${i} ==> ${isAlreadyLiked}");
        isAlreadyLikedList.add(isAlreadyLiked);
      }
      print("feed ==>${userFeedListModel.length}");
      print("like ==>${isAlreadyLikedList.length}");
    }
    if (response is Failure) {
      ErrorModel userFeedError = ErrorModel(
        response.code,
        response.errorMessage,
      );
      setuserFeedError(userFeedError);
    }
    // Utils.showSnackBar("new Data Fetched");
    print("new Data fetched");
    setLoading(false);
    adddFeedToSahredPref(userFeedListModel, isAlreadyLikedList);
  }

  adddFeedToSahredPref(
      List<UserFeedModel> feedList, List<bool> isAlreadyLikedList) async {
    SharedPreferences feedPrefs = await SharedPreferences.getInstance();
    bool isFeedStored = feedPrefs.containsKey('feedList');
    bool isLikedStored = feedPrefs.containsKey('isAlreadyLikedList');
    if (isFeedStored) {
      await feedPrefs.remove("feedList");
    }
    if (isLikedStored) {
      await feedPrefs.remove("isAlreadyLikedList");
    }
    feedPrefs.setString("feedList", userFeedModelToJson(feedList));
    feedPrefs.setStringList(
        "isAlreadyLikedList", boolListTOStringList(isAlreadyLikedList));
  }

  List<String> boolListTOStringList(List<bool> listBool) {
    List<String> listString = [];
    listBool.forEach((item) {
      item == true ? listString.add("true") : listString.add("false");
    });
    return listString;
  }

  Future<List<bool>> getIsLikedPref() async {
    SharedPreferences likedpref = await SharedPreferences.getInstance();
    List<String>? likedlist = likedpref.getStringList("isAlreadyLikedList");
    print("klsf");
    print(likedlist);
    if (likedlist != null) {
      List<bool> isAlreadyLikedList = stringListToBoolList(likedlist);
      return isAlreadyLikedList;
    }
    return [];
  }

  List<bool> stringListToBoolList(List<String> likedlist) {
    List<bool> boolList = [];
    for (var item in likedlist) {
      item == "true" ? boolList.add(true) : boolList.add(false);
    }
    return boolList;
  }

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
    }
  }
}
