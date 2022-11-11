import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelPage extends StatelessWidget {
  final Channel ch;
  const ChannelPage({Key? key, required this.ch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sanat"),
          backgroundColor: bgColor,
          actions: [
            IconButton(
                splashRadius: 1,
                onPressed: () async {
                  await ch.delete();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.cancel)),
            IconButton(
                splashRadius: 1,
                onPressed: () async {},
                icon: Icon(Icons.report)),
          ],
        ),
        body: Column(children: const [
          Expanded(
            child: StreamMessageListView(),
          ),
          StreamMessageInput(
            disableAttachments: true,
          ),
        ]),
      ),
    );
  }
}
