import '../models/user_profile/user_model.dart';

class Globals {
  static late String refreshToken;
  static late String? email;
  static late String? password;
  static bool? isuserhavedata = false;
  static UserModel presentUser = UserModel(
      firstName: "firstName",
      lastName: "lastName",
      firebase: 'firebase',
      name: "name",
      gender: "M",
      phone: "phone",
      chatAllowed: true,
      chatReports: 0,
      email: "email",
      score: 0,
      instagramId: "instagramId",
      profileImage: "profileImage");
  static String authToken = "";
}
