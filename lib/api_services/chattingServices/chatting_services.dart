import 'dart:convert';
import 'dart:io';
import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/utils/snackbar.dart';
import 'package:http/http.dart' as http;
import '../../models/chatting/getChat_messages_mode.dart';
import '../../utils/api_constants.dart';
import '../auth_services.dart';

class ChattingServices {
  static getChatRoom(String nickName, String fbId) async {
    http.Response? response;
    try {
      Map<String, String> header = await AuthServices.getAuthHeader();
      var url = Uri.parse("$getChatRoomUrl/$fbId/");
      response = await http.post(
        url,
        headers: header,
        body: jsonEncode(<String, String>{
          'nickname1': nickName,
        }),
      );
      print("getChatRoom==> ${response.statusCode}");
      // if (postSuccessCode == response.statusCode) {
      //   return Success(
      //           code: postSuccessCode,
      //           response: getChatRoomModelFromJson(response.body))
      //       as GetChatRoomModel;
      // }
      // return Failure(code: invalidResponse, errorMessage: 'Invalid Response');
      return response;
    }
    // on HttpException {
    //   return Failure(code: noInternet, errorMessage: 'No Internet');
    // } on FormatException {
    //   return Failure(code: invalidFormat, errorMessage: 'Invalid Format');
    // }
    catch (e) {
      // return Failure(code: unknownError, errorMessage: e.toString());
      return response;
    }
  }

  static Future<Object> getMessages(String roomId) async {
    try {
      var url = Uri.parse("$getMessagesUrl/$roomId/");
      var response = await http.get(url);
      if (getSuccessCode == response.statusCode) {
        return Success(
            code: getSuccessCode,
            response: getChatMessagesModelFromJson(response.body));
      }

      return Failure(code: invalidResponse, errorMessage: 'Invalid Response');
    } on HttpException {
      return Failure(code: noInternet, errorMessage: 'No Internet');
    } on FormatException {
      return Failure(code: invalidFormat, errorMessage: 'Invalid Format');
    } catch (e) {
      return Failure(code: unknownError, errorMessage: e.toString());
    }
  }

  static Future<Object> postChats(
      String message, String roomId, String fbId) async {
    http.Response? response;
    try {
      var url = Uri.parse("$getChatRoomUrl/$fbId/");
      response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(
            <String, String>{'value': message, 'sender': fbId, 'room': roomId}),
      );
      if (postSuccessCode == response.statusCode) {
        return Success(code: postSuccessCode, response: response.body);
      }
      return Failure(code: invalidResponse, errorMessage: 'Invalid Response');
    } on HttpException {
      return Failure(code: noInternet, errorMessage: 'No Internet');
    } on FormatException {
      return Failure(code: invalidFormat, errorMessage: 'Invalid Format');
    } catch (e) {
      return Failure(code: unknownError, errorMessage: e.toString());
    }
  }

  static Future<bool> check2ndChatter(String roomId) async {
    bool is2ndChatter = false;
    try {
      Map<String, String> header = await AuthServices.getAuthHeader();
      var url = Uri.parse("$checkChater/$roomId");
      var response = await http.get(url, headers: header);
      if (getSuccessCode == response.statusCode) {
        Map<String, dynamic> map = jsonDecode(response.body);
        is2ndChatter = map['chatter2_present'];
        return is2ndChatter;
      } else {
        Utils.showSnackBar(response.body);
        return is2ndChatter;
      }
    } catch (e) {
      return Utils.showSnackBar(e.toString());
    }
  }
}
