import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'new_channelPage.dart';

class NewChatting extends StatelessWidget {
  const NewChatting(
      {super.key,
      required this.client,
      required this.channel,
      required this.user1,
      required this.user2});

  final StreamChatClient client;
  final Channel channel;
  final String user1;
  final String user2;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hillffair',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      builder: ((context, child) {
        return StreamChat(client: client, child: child);
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
