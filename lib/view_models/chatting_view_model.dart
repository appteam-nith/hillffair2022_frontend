import 'package:flutter/cupertino.dart';
import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/api_services/chatting_services.dart';
import 'package:hillfair2022_frontend/models/error_model.dart';

import '../models/userFeed/post_img_model.dart';
import 'package:http/http.dart' as http;

class ChattingViewModel extends ChangeNotifier {
  bool _isBack = false;
  ErrorModel _getChatRoomError = ErrorModel(000, "initial value of error");

  get isBack => _isBack;
  setIsBack(bool isBack) async {
    _isBack = isBack;
    notifyListeners();
  }

 

  get getChatRoomError => _getChatRoomError;
  setGetChatRoomError(ErrorModel getChatRoomError) {
    _getChatRoomError = getChatRoomError;
  }

  getChatRoom(String nickName, String fbId) async {
    setIsBack(false);
    var respone = await ChattingServices.getChatRoom(nickName, fbId);
    if (respone is Success) {
      ////to be completed by chatting team
    }
    if (respone is Failure) {
      ErrorModel getChatRoomError =
          ErrorModel(respone.code, respone.errorMessage);
      setGetChatRoomError(getChatRoomError);
    }
    setIsBack(true);
  }

  
}
