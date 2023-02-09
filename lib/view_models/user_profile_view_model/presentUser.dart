import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_profile/user_model.dart';

class PresentUser extends ChangeNotifier {

  PresentUser() {
    initializeUser();
  }

  static getPresentUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userData = sharedPreferences.getString("presentUser");
    return userModelFromJson(userData!);
  }

  setPresentUser(UserModel presentUse) {
    notifyListeners();
  }

  initializeUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userData = sharedPreferences.getString("presentUser");
    setPresentUser(userModelFromJson(userData!));
    return userModelFromJson(userData);
  }
}
