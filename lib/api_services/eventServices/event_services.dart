import 'dart:io';
import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/models/events/newEvent_model.dart';
import 'package:http/http.dart' as http;
import '../../utils/api_constants.dart';
import '../auth_services.dart';

class EventServices {
  static Future<Object> getEvents() async {
    try {
      // var acTokenUrl = Uri.parse(accessTokenUrl);
      // Map<String, String> accessBody = {"refresh": Globals.authToken};
      // var accessTokenRes = await http.post(acTokenUrl, body: accessBody);
      // AccessTokenModel accessToken = accessTokenModelFromJson(accessTokenRes.body);

      // //Authorization header
      // Map<String, String> header = {'Authorization': "Bearer ${accessToken.access}",'content-type': 'application/json'};
      Map<String, String> header = await AuthServices.getAuthHeader();
      var url = Uri.parse(eventUrl);
      var response = await http.get(url, headers: header);
      print("events data");
      print(response.body);
      if (getSuccessCode == response.statusCode) {
        print(newEventsModelFromJson(response.body).toString());
        return Success(
            code: getSuccessCode,
            response: newEventsModelFromJson(response.body));
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
}
