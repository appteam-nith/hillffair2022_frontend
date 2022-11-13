import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'new_channelPage.dart';

class NewChatting extends StatelessWidget {
  const NewChatting({
    super.key,
    required this.client,
    required this.channel,
    required this.isCreatedByMe,
    required this.members
  });

  final StreamChatClient client;
  final Channel channel;
  final bool isCreatedByMe;
  final List<String> members;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      primarySwatch: Colors.green,
    );

    return Builder(
      builder: ((context) {
        return StreamChat(
          client: client,
          child:  StreamChannel(
        channel: channel,
        child: ChannelPage(
          members: members,
          ch: channel,
          removeMembers: isCreatedByMe,
        ),
      ),
          streamChatThemeData: StreamChatThemeData.fromTheme(theme).copyWith(
              ownMessageTheme: StreamMessageThemeData(
                messageTextStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                messageBackgroundColor: Color.fromARGB(255, 61, 60, 60),
              ),
              otherMessageTheme: StreamMessageThemeData(
                  messageTextStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                  messageBackgroundColor: Color.fromARGB(255, 0, 0, 0))),
        );
      }),
    );
  }
}
