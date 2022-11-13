import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelPage extends StatelessWidget {
  final Channel ch;
  final bool removeMembers;
  final List<String> members;
  const ChannelPage(
      {Key? key,
      required this.ch,
      required this.removeMembers,
      required this.members})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: StreamChannelHeader(
          backgroundColor: bgColor,
          onBackPressed: () async {
            if (true) {
              RemoveMembersResponse remove = await ch.removeMembers(members);
              print(remove.message);
              EmptyResponse destroy = await ch.delete();
              print(destroy.duration);
            }
            Navigator.pop(context);
          },
          title: Text(
            'Anonymous',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          actions: [
            IconButton(
              splashRadius: 1,
              onPressed: () async {
                // TODO: report other user
              },
              icon: Icon(
                Icons.report,
              ),
            ),
          ],
        ),
        // appBar: AppBar(
        //   title: Text("Anonymous"),
        //   backgroundColor: bgColor,
        //   actions: [
        //     IconButton(
        //         splashRadius: 1,
        //         onPressed: () async {
        //           if (removeMembers) {
        //             var res = await ch.removeMembers(members);
        //             print(res.message);
        //           }
        //           var result = await ch.delete();
        //           print(result.toString());

        //           print(result);
        //           Navigator.pop(context);
        //           // Navigator.pop(context);
        //           // print("pop2");
        //         },
        //         icon: Icon(Icons.cancel)),
        //     IconButton(
        //         splashRadius: 1,
        //         onPressed: () async {},
        //         icon: Icon(Icons.report)),
        //   ],
        // ),
        body: Column(children: [
          Expanded(
            child: StreamMessageListView(
              messageBuilder:
                  ((context, details, messageList, defaultMessageWidget) {
                return defaultMessageWidget.copyWith(
                  showUsername: false,
                  showUserAvatar: DisplayWidget.gone,
                  messageTheme: StreamMessageThemeData(
                    messageBorderColor: Colors.transparent,
                    messageBackgroundColor: msgColor,
                    messageTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                );
              }),
            ),
          ),
          StreamMessageInput(
            disableAttachments: true,
          ),
        ]),
      ),
    );
  }
}
