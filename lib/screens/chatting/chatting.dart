import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/api_services/chatting_services.dart';
import 'package:hillfair2022_frontend/screens/chatting/upcoming.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/utils/global.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import '../../components/loading_data.dart';
import '../../models/chatting/getChat_Room_model.dart';
import '../../utils/snackbar.dart';
import 'new_chatting.dart';

class Chatting extends StatefulWidget {
  Chatting({super.key});

  @override
  State<Chatting> createState() => _Chatting();
}

class _Chatting extends State<Chatting> {
  bool isGetRoomLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          color: bgColor,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: 380.0,
                    width: 320.0,
                    color: Colors.transparent,
                    child: Container(
                      alignment: Alignment.topCenter,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: const Text(
                          'Guidelines',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(60),
                    child: const Text(
                      "This is an exclusive application for Hill'ffair 2k22. The chatting feature is Solely meant for users to interact with peers and discuss their interests. We do not promote hate messages and irrelevant contexts. Abide by this guideline falling to it will be responsible for the disciplinary actions.",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 16,
                        //fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                      width: 500,
                      height: 380,
                      child: Container(
                        margin: EdgeInsets.all(15),
                        color: Colors.transparent,
                        width: 100,
                        height: 40,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                              child: Text("I Agree",
                                  style: TextStyle(fontSize: 16)),
                              style: ButtonStyle(
                                  splashFactory: NoSplash.splashFactory,
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.deepPurple),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ))),
                              onPressed: () async {
                                
                                // showDialog(
                                //     context: context,
                                //     barrierDismissible: false,
                                //     builder: (context) {
                                //       return WillPopScope(
                                //           onWillPop: () async {
                                //             if (isGetRoomLoading) {
                                //               return true;
                                //             }
                                //             return false;
                                //           },
                                //           child: LoadingData());
                                //     });
                                // var res = await getchatRoom(
                                //     Globals.presentUser.firebase);

                                // if (!res) {
                                //   Navigator.pop(context);
                                // }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Upcoming(),
                                  ),
                                );
                              }),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ],
    ));
  }

  Future<bool> getchatRoom(String fbId) async {
    isGetRoomLoading = true;
    const apiKey = "mrpy76fbejbr";
    var response = await ChattingServices.getChatRoom("anonymous", fbId);
    GetChatRoomModel getChatRoomModel = getChatRoomModelFromJson(response.body);
    if (getChatRoomModel.chater2 == null) {
      //check cahtter
      var count = 1;
      for (var i = 0; i < 10; i++) {
        Timer(Duration(seconds: 2), () async {
        print("timer 2sec ${i}");
        bool chatter2 =
            await ChattingServices.check2ndChatter(getChatRoomModel.roomId);
        if (chatter2) {
          final client = StreamChatClient(apiKey);
          String userId1 = getChatRoomModel.chater1;
          await client.connectUser(
              User(id: userId1), client.devToken(userId1).rawValue);
          // Get channel
          final channel =
              client.channel("messaging", id: getChatRoomModel.roomId);
          await channel.watch();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewChatting(
                        client: client,
                        channel: channel,
                        isCreatedByMe: false,
                        members: [userId1],
                      )));
          setState(() {
            isGetRoomLoading = false;
          });
        }
        if (count == 10) {
          Utils.showSnackBar(
              "no other chatter is available now, try after some time");
          isGetRoomLoading = false;
        }

        });
        count++;
        print(count);
      }
    }
    //2nd chatter already present
    if (getChatRoomModel.chater2 != null) {
      final client = StreamChatClient(apiKey, logLevel: Level.INFO);
      // Current users
      String userId1 = getChatRoomModel.chater1;
      String userId2 = getChatRoomModel.chater2!;
      await client.connectUser(
          User(id: userId2), client.devToken(userId2).rawValue);
      // Get channel
      final channel = client.channel("messaging", id: getChatRoomModel.roomId);
      await channel.create();
      AddMembersResponse result = await channel.addMembers([userId2, userId1]);
      print("AddMembersResponse ${result.members}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewChatting(
            client: client,
            channel: channel,
            isCreatedByMe: true,
            members: [userId2, userId1],
          ),
        ),
      );
      setState(() {
        isGetRoomLoading = false;
      });
    }
    return isGetRoomLoading;
  }
}
