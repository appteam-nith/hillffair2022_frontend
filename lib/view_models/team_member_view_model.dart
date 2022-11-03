import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/models/error_model.dart';
import '../api_services/api_status.dart';
import '../api_services/team_member_services.dart';
import '../models/teams/team_member_model.dart';

class TeamMemberViewModel extends ChangeNotifier {
  TeamMemberViewModel() {
    getTeamMembers();
  }

  bool _loading = false;
  List<TeamMemberModel> _teamMembersListModel = [];
  ErrorModel _teamMembersError = ErrorModel(000, " error not set");

  bool get loading => _loading;
  List<TeamMemberModel> get teamMembersListModel => _teamMembersListModel;
  ErrorModel get teamMembersError => _teamMembersError;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setTeamMembersListModel(List<TeamMemberModel> teamMembersListModel) {
    _teamMembersListModel = teamMembersListModel;
  }

  setteamMembersError(ErrorModel teamMembersError) {
    _teamMembersError = teamMembersError;
  }

  getTeamMembers() async {
    setLoading(true);
    var response = await TeamMemberService.getTeamMembers();
    if (response is Success) {
      setTeamMembersListModel(response.response as List<TeamMemberModel>);
    }
    if (response is Failure) {
      ErrorModel teamMembersError = ErrorModel(
        response.code,
        response.errorMessage,
      );
      setteamMembersError(teamMembersError);
    }
    setLoading(false);
  }
}
