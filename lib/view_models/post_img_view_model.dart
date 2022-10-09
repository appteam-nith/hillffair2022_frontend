import 'package:flutter/cupertino.dart';
import 'package:hillfair2022_frontend/api_services/post_img_service.dart';

import '../models/post_img_model.dart';
import 'package:http/http.dart' as http;

class PostImgViewModel extends ChangeNotifier {
  bool loading = false;
  bool isBack = false;
  postImg(PostImgModel data, String id) async {
    loading = true;
    notifyListeners();
    var response = (await PostImgServices.postImgS(data, id))!;
    if (response.statusCode == 201) {
      isBack = true;
    }
    loading = false;
    notifyListeners();
  }
}
