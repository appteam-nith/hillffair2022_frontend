import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelPage extends StatelessWidget {
  final Channel ch;
  const ChannelPage({Key? key, required this.ch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        actions: [
          IconButton(
              onPressed: () async {
                await ch.delete();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              icon: Icon(Icons.cancel))
        ],
      ),
      body: Column(children: const [
        Expanded(
          child: StreamMessageListView(),
        ),
        StreamMessageInput(),
      ]),
    );
  }
}
