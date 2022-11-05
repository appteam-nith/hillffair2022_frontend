import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/api_services/chatting_services.dart';
import 'package:hillfair2022_frontend/models/chatting/getChat_messages_mode.dart';
import 'package:hillfair2022_frontend/models/error_model.dart';
import '../api_services/api_status.dart';

class ChatMessagesVM extends ChangeNotifier {
  ChatMessagesVM() {
    // getMessageList();
  }

  bool _loading = false;
  List<GetChatMessagesModel> _messageList = [];
  ErrorModel _chatMessageError = ErrorModel(000, " error not set");

  bool get loading => _loading;
  List<GetChatMessagesModel> get messageList => _messageList;
  ErrorModel get chatMessageError => _chatMessageError;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setMessageList(List<GetChatMessagesModel> messageList) {
    _messageList = messageList;
  }

  setMessageError(ErrorModel chatMessageError) {
    _chatMessageError = chatMessageError;
  }

  getMessageList(String roomID)  {
    Timer.periodic(Duration(seconds: 20), (timer) async {
      setLoading(true);
    var response = await ChattingServices.getMessages(roomID);
    if (response is Success) {
      setMessageList(response.response as List<GetChatMessagesModel>);
      log(response.response.toString());
    }
    if (response is Failure) {
      ErrorModel chatMessageError = ErrorModel(
        response.code,
        response.errorMessage,
      );
      setMessageError(chatMessageError);
    }
    setLoading(false);
    });
    
  }
}
