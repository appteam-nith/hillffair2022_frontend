import 'package:flutter/cupertino.dart';
import 'package:hillfair2022_frontend/api_services/api_status.dart';
import 'package:hillfair2022_frontend/api_services/userFeedServicies/getLIker_services.dart';
import 'package:hillfair2022_frontend/models/error_model.dart';
import 'package:hillfair2022_frontend/models/userFeed/get_liker_model.dart';

class GetLikerViewModel extends ChangeNotifier {
  bool _isAlreadyLiked = false;
  bool _loading = false;
  ErrorModel _getLikerError = ErrorModel(000, "not set yet");

  bool get isAlreadyLiked => _isAlreadyLiked;
  bool get loading => _loading;
  ErrorModel get getLikerError => _getLikerError;

  setLoading(bool loading) async {
    _loading = loading;
    // notifyListeners();
  }

  setIsAlreadyLiked(bool isAlreadyLikes) {
    _isAlreadyLiked = isAlreadyLikes;
  }

  setGetLikerError(ErrorModel getLikerError) {
    _getLikerError = getLikerError;
  }

  Future<bool> getLiker(String fbId, String postId) async {
    setLoading(true);
    var response = await GetLikerServices.getLikers(postId);
    if (response is Success) {
      //check for user fbId
      GetLIkerModel likersData = response.response as GetLIkerModel;
      int n = likersData.results.length;
      for (var i = 0; i < n; i++) {
        if (likersData.results[i].firebase == fbId) {
          setIsAlreadyLiked(true);
        } else {
          setIsAlreadyLiked(false);
        }
      }
    }
    if (response is Failure) {
      ErrorModel getLikerError = ErrorModel(
        response.code,
        response.errorMessage,
      );
      setGetLikerError(getLikerError);
    }
    setLoading(false);
    return isAlreadyLiked;
  }
}
