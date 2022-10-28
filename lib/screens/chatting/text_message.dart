// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../models/chatting/chatmessage.dart';
import '../../utils/colors.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: MediaQuery.of(context).platformBrightness == Brightness.dark
      //     ? Colors.white
      //     : Colors.black,
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: message!.isSender ? Color(0xffB2E4FA) : Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message!.text,
        style: TextStyle(),
      ),
    );
  }
}
