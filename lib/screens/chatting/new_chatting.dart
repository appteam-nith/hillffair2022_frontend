import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'new_channelPage.dart';

class NewChatting extends StatelessWidget {
  const NewChatting({super.key, required this.client, required this.channel});

  final StreamChatClient client;
  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: ((context, child) {
        return StreamChat(client: client, child: child);
      }),
      home: StreamChannel(
        channel: channel,
        child: const ChannelPage(),
      ),
    );
  }
}
