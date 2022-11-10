import 'dart:async';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/api_services/chatting_services.dart';
import 'package:hillfair2022_frontend/models/chatting/getChat_Room_model.dart';
import 'package:hillfair2022_frontend/utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_profile/user_model.dart';
import 'message_screen.dart';
import 'new_chatting.dart';

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
  const apiKey = "mrpy76fbejbr";
  var response = await ChattingServices.getChatRoom("anonymous", fbId);

  // if (response is Success) {

  GetChatRoomModel getChatRoomModel = getChatRoomModelFromJson(response.body);
  if (getChatRoomModel.chater2 == null) {
    //check cahtter
    int count = 0;
    Timer(Duration(seconds: 10), () {
      Timer.periodic(Duration(seconds: 10), (timer) async {
        bool chatter2 =
            await ChattingServices.check2ndChatter(getChatRoomModel.roomId);
        print("${chatter2} ==> ${count}");
        if (chatter2) {
          timer.cancel();

          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => MessagesScreen()));

          // WidgetsFlutterBinding.ensureInitialized();
          final client = StreamChatClient(apiKey, logLevel: Level.INFO);

          // Current user
          // String userId1 = getChatRoomModel.chater1;
          // String? userId2 = getChatRoomModel.chater2;
          String userId1 = getChatRoomModel.chater1;
          // String? userId2 = "Sanat";
          var user1 = User(id: userId1);
          await client.connectUser(user1, client.devToken(user1.id).rawValue);

          // Get channel
          final channel =
              client.channel("messaging", id: getChatRoomModel.roomId);
          await channel.watch();

          // var result = await channel.addMembers([user1.id, userId2]);
          print("upper");
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             NewChatting(client: client, channel: channel)));
          print("nicha");
          return;
        }
        count++;
        if (count == 10) {
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
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => MessagesScreen()));

    // WidgetsFlutterBinding.ensureInitialized();
    final client = StreamChatClient(apiKey, logLevel: Level.INFO);

    // Current user

    String userId1 = getChatRoomModel.chater1;
    String userId2 = getChatRoomModel.chater2!;
    var user2 = User(id: userId2);
    // await client.d
    var user1 = User(id: userId1);
    await client.connectUser(user2, client.devToken(user2.id).rawValue);

    // Get channel
    final channel = client.channel("messaging", id: getChatRoomModel.roomId);

    await channel.watch();
    var result = await channel.addMembers([user2.id, user1.id]);
    print("upper");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                NewChatting(
                  client: client,
                  channel: channel,
                  user1: user1.id,
                  user2: user2.id,
                )));
    print("nicha");
    return;
  }
  // }
}
