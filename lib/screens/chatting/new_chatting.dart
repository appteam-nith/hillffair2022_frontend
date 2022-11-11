import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'new_channelPage.dart';

class NewChatting extends StatelessWidget {
  const NewChatting({
    super.key,
    required this.client,
    required this.channel,
  });

  final StreamChatClient client;
  final Channel channel;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      primarySwatch: Colors.green,
    );

    return MaterialApp(
      title: 'Hillffair',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      builder: ((context, child) {
        return StreamChat(
          client: client,
          child: child,
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
        ;
      }),
      home: StreamChannel(
        channel: channel,
        child: ChannelPage(
          ch: channel,
        ),
      ),
    );
  }
}
