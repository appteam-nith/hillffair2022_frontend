import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/models/error_model.dart';
import '../api_services/api_status.dart';
import '../api_services/team_services.dart';
import '../models/team_model.dart';

class TeamViewModel extends ChangeNotifier {
  TeamViewModel() {
    getTeams();
  }

  bool _loading = false;
  List<TeamModel> _teamsListModel = [];
  ErrorModel _teamError = ErrorModel(000, " error not set");

  bool get loading => _loading;
  List<TeamModel> get teamsListModel => _teamsListModel;
  ErrorModel get teamError => _teamError;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setTeamListModel(List<TeamModel> teamsListModel) {
    _teamsListModel = teamsListModel;
  }

  setteamError(ErrorModel teamError) {
    _teamError = teamError;
  }

  getTeams() async {
    setLoading(true);
    var response = await TeamServices.getTeams();
    if (response is Success) {
      setTeamListModel(response.response as List<TeamModel>);
      log(response.response.toString());
    }
    if (response is Failure) {
      ErrorModel teamError = ErrorModel(
        response.code,
        response.errorResponse,
      );
      setteamError(teamError);
    }
    setLoading(false);
  }
}
