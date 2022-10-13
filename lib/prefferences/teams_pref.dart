import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/team_model.dart';

class SharedPreferencesTeams{
  static SharedPreferences? _preferences;
  static const teamsKey="teams";
  static init()async{
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }
  static saveTeams(String n) async {
    List<String> teamsList = await getTeamsList();
    teamsList.add(n);
    print(teamsList);
    return _preferences!.setStringList(teamsKey, teamsList);

  }
  static Future<List<String>> getTeamsList() async {
    return _preferences!.getStringList(teamsKey) ?? [];
  }

  static Future<List<TeamModel>> getTeams() async {
    List<String> teamList = await getTeamsList();
    List<TeamModel> teamModelList = [];
    for (String eventString in teamList) {
      teamModelList.add(TeamModel.fromJson(jsonDecode(eventString)));
    }

    print(teamModelList);

    return teamModelList;
  }
}