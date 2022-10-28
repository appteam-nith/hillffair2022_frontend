// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/screens/chatting/message_screen.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text(
          "Messages",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) =>
                  [PopupMenuItem(child: Text("Something"))])
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * .02),
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => MessagesScreen())));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * .02,
                      vertical: size.height * .01),
                  child: Container(
                    height: size.height * .1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          // to do -> cached image to be used
                          child: Image(
                              image: AssetImage("assets/images/member.png")),
                        ),
                        title: Text(
                          "username",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "I know right!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          height: size.height * .028,
                          width: size.width * .06,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: bgColor),
                          child: Center(
                            child: Text(
                              "1",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            })),
      ),
    );
  }
}
