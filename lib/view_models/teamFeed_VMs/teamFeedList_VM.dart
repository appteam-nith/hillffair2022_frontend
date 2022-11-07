import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/api_services/team_member_services.dart';
import 'package:hillfair2022_frontend/models/error_model.dart';
import 'package:hillfair2022_frontend/models/teamFeed/newTeamFeedModel.dart';
import 'package:hillfair2022_frontend/models/teamFeed/teamFeed_model.dart';
import 'package:hillfair2022_frontend/utils/snackbar.dart';
import 'package:hillfair2022_frontend/view_models/teamFeed_VMs/teamFeed_liker_VM.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_services/api_status.dart';
import '../../api_services/teamFeedServices/teamFeed_list.dart';
import '../../api_services/userFeedServicies/userFeed_services.dart';
import '../../models/userFeed/user_feed_model.dart';
import '../../models/user_profile/user_model.dart';
import '../userFeed_viewModels/getLikerViewModel.dart';

class TeamFeedViewModel extends ChangeNotifier {
  TeamFeedViewModel() {
    getTeamFeed();
    // getPresentUser();
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

  List<TeamFeedModel> prefTeamFeedList = [];
  bool _loading = false;
  List<TeamFeedModel> _teamFeedListModel = [];
  ErrorModel _teamFeedError = ErrorModel(000, " error not set");

  bool get loading => _loading;
  List<TeamFeedModel> get teamFeedListModel => _teamFeedListModel;
  ErrorModel get teamFeedError => _teamFeedError;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setTeamFeedListModel(List<TeamFeedModel> teamFeedListModel) {
    _teamFeedListModel = teamFeedListModel;
    notifyListeners();
  }

  setTeamFeedError(ErrorModel teamFeedError) {
    _teamFeedError = teamFeedError;
  }

  getTeamFeed() async {
    getPresentUser();
    prefTeamFeedList = await getFeedPref();
    setLoading(true);
    //

    // prefTeamFeedList = await getFeedPref();
    // prefIsLikedList = await getIsLikedPref();
    //
    var response = await TeamFeedList.getTeamFeed(nxtUrl, prevUrl);
    if (response is Success) {
      NewTeamFeedModel teamFeed = response.response as NewTeamFeedModel;
      nxtUrl = teamFeed.next;
      setTeamFeedListModel(teamFeedListModel+teamFeed.results);
      adddFeedToSahredPref(teamFeed.results);
      log(response.response.toString());
    }
    if (response is Failure) {
      ErrorModel teamFeedError = ErrorModel(
        response.code,
        response.errorMessage,
      );
      setTeamFeedError(teamFeedError);
    }
    Utils.showSnackBar("new TeamFeed Fetched");
    print("new Data fetched");
    setLoading(false);
    
  }

  adddFeedToSahredPref(List<TeamFeedModel> teamFeedList) async {
    SharedPreferences feedPrefs = await SharedPreferences.getInstance();
    bool isFeedStored = feedPrefs.containsKey('teamFeedList');
    if (isFeedStored) {
      await feedPrefs.remove("teamFeedList");
    }
  feedPrefs.setString("teamFeedList", teamFeedModelToJson(teamFeedList));

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
  //   List<String>? likedlist =
  //       likedpref.getStringList("isTeamFeedAlreadyLikedList");
  //   if (likedlist != null) {
  //     List<bool> isTeamFeedAlreadyLikedList = stringListToBoolList(likedlist);
  //     return isTeamFeedAlreadyLikedList;
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

  Future<List<TeamFeedModel>> getFeedPref() async {
    SharedPreferences feedPrefs = await SharedPreferences.getInstance();
    String? feedJsonList = feedPrefs.getString("teamFeedList");
    if (feedJsonList != null) {
      List<TeamFeedModel> teamFeedList = teamFeedModelFromJson(feedJsonList);
      return teamFeedList;
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
