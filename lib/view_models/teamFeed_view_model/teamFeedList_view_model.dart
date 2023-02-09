import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/models/error_model.dart';
import 'package:hillfair2022_frontend/models/teamFeed/newTeamFeedModel.dart';
import 'package:hillfair2022_frontend/models/teamFeed/teamFeed_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_services/api_status.dart';
import '../../api_services/teamFeedServices/teamFeed_list.dart';
import '../../models/user_profile/user_model.dart';
import '../../utils/global.dart';

class TeamFeedViewModel extends ChangeNotifier {
  TeamFeedViewModel() {
    getPresentUser();
    getTeamFeed();
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

  List<TeamFeedModel> prefTeamFeedList = [];
  bool _loading = false;
  bool _refreshLoading = false;
  List<TeamFeedModel> _teamFeedListModel = [];
  ErrorModel _teamFeedError = ErrorModel(000, " error not set");

  bool get loading => _loading;
  bool get refreshLoading => _refreshLoading;
  List<TeamFeedModel> get teamFeedListModel => _teamFeedListModel;
  ErrorModel get teamFeedError => _teamFeedError;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setRefreshLoading(_refreshLoading) async {
    _refreshLoading = _refreshLoading;
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
    if (isFirst) {
      prefTeamFeedList = await getFeedPref();
      isFirst = false;
    } else {
      prefTeamFeedList = teamFeedListModel;
    }
    // prefTeamFeedList = await getFeedPref();
    setLoading(true);
    var response = await TeamFeedList.getTeamFeed(nxtUrl, prevUrl);
    if (response is Success) {
      NewTeamFeedModel teamFeed = response.response as NewTeamFeedModel;
      nxtUrl = teamFeed.next;
      setTeamFeedListModel(teamFeedListModel + teamFeed.results);
      adddFeedToSahredPref(teamFeed.results);
    }
    if (response is Failure) {
      ErrorModel teamFeedError = ErrorModel(
        response.code,
        response.errorMessage,
      );
      setTeamFeedError(teamFeedError);
    }
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
    // SharedPreferences userPrefs = await SharedPreferences.getInstance();
    // String? prseentUserJson = userPrefs.getString("presentUser");
    // if (prseentUserJson!.isNotEmpty) {
    //   UserModel presentUser = userModelFromJson(prseentUserJson);
      setPrensentUser(Globals.presentUser);
    // }
  }

  refesh() async {
    setRefreshLoading(true);
    var response = await TeamFeedList.getTeamFeed("nxtUrl", "prevUrl");
    if (response is Success) {
      NewTeamFeedModel feed = response.response as NewTeamFeedModel;
      int diffIndex = 0;
      for (var i = 0; i < feed.results.length; i++) {
        if (feed.results[i].id == teamFeedListModel[0].id) {
          diffIndex = i;
          break;
        }
      }
      var newList = feed.results.getRange(0, diffIndex).toList();
      setTeamFeedListModel(newList + teamFeedListModel);
      setRefreshLoading(false);
    }
    if (response is Failure) {
      ErrorModel userFeedError = ErrorModel(
        response.code,
        response.errorMessage,
      );
      setTeamFeedError(userFeedError);
    }
  }
}
