import '../models/tokens/accTokenModel.dart';
import '../utils/api_constants.dart';
import '../utils/global.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  static Future<Map<String, String>> getAuthHeader() async {
    var acTokenUrl = Uri.parse(accessTokenUrl);
    Map<String, String> accessBody = {"refresh": Globals.authToken};
    var accessTokenRes = await http.post(acTokenUrl, body: accessBody);
    AccessTokenModel accessToken =
        accessTokenModelFromJson(accessTokenRes.body);

    //Authorization header
    Map<String, String> header = {
      'Authorization': "Bearer ${accessToken.access}",
      'content-type': 'application/json'
    };
    return header;
  }
}
