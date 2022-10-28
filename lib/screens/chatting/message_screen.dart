// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/screens/chatting/body.dart';

import '../../utils/colors.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: bgColor,
      automaticallyImplyLeading: true,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/member.png"),
          ),
          SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Username",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "online",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        PopupMenuButton(
            itemBuilder: (context) => [PopupMenuItem(child: Text("Edit"))])
      ],
    );
  }
}
