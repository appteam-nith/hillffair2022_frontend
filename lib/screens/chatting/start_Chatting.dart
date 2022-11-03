import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/api_services/chatting_services.dart';
import 'package:hillfair2022_frontend/models/chatting/getChat_Room_model.dart';
import 'package:hillfair2022_frontend/utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_profile/user_model.dart';
import 'message_screen.dart';

class StartChatting extends StatelessWidget {
  const StartChatting({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          child: Text("Start Chatting", style: TextStyle(fontSize: 16)),
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.deepPurple),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),
          onPressed: () async {
            //get present user
            SharedPreferences userPrefs = await SharedPreferences.getInstance();
            String? prseentUserJson = userPrefs.getString("presentUser");
            UserModel presentUser = userModelFromJson(prseentUserJson!);

            //getchatRoom
            getchatRoom(presentUser.firebase, context);
          }),
    );
  }
}

void getchatRoom(String fbId, BuildContext context) async {
  var response = await ChattingServices.getChatRoom("anonymous", fbId);

  // if (response is Success) {

    GetChatRoomModel getChatRoomModel = getChatRoomModelFromJson(response.body);
    if (getChatRoomModel.chater2 == null) {
      //check cahtter
      int count = 0;
      Timer(Duration(seconds: 20), () {
        
        Timer.periodic(Duration(seconds: 20), (timer) async {
          bool isChatter2 =
              await ChattingServices.check2ndChatter(getChatRoomModel.roomId);
          if (isChatter2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MessagesScreen()));
            timer.cancel();
          }
          count++;
          if (count == 2) {
            Utils.showSnackBar(
                "no other chatter is available now, try after some time");
            timer.cancel();
            Navigator.pop(context);
          }
        });
      });
    }
    //2nd chatter already present
    if (getChatRoomModel.chater2 != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MessagesScreen()));
    }
  // }
}
