import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';
import 'package:hillfair2022_frontend/models/tokens/twoTokenModel.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/utils/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../../models/user_profile/postUser_model.dart';
import '../../utils/api_constants.dart';
import '../../utils/snackbar.dart';
import '../bottomnav/nav.dart';

class PostUser extends StatefulWidget {
  var email;

  // String fbId;
  var password;

  PostUser(this.email, this.password, {super.key});

  // PostUser(this.email, this.fbId, this.password, {super.key});

  @override
  State<PostUser> createState() => _PostUserState();
}

class _PostUserState extends State<PostUser> {
  String val = "";
  final _formkey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  late final TextEditingController email;
  late final TextEditingController pass;
  final userName = TextEditingController();
  final gender = TextEditingController();
  final instaId = TextEditingController();
  final phoneNo = TextEditingController();

  @override
  void initState() {
    // Navigator.popUntil(context, (route) => route.isFirst);
    email = TextEditingController(text: widget.email);
    pass = TextEditingController(text: widget.password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String fbId = FirebaseAuth.instance.currentUser!.uid;

    return WillPopScope(
      onWillPop: (() async {
        return false;
      }),
      child: Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .08),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * .07,
                      ),
                      // will take profile image in edit profile page

                      // GestureDetector(
                      //   onTap: () {
                      //     chooseImage();
                      //   },
                      //   child: CircleAvatar(
                      //     radius: 50,
                      //     backgroundColor: Colors.white,
                      //     child: ClipOval(
                      //         child: selectedImage != null
                      //             ? Image.file(
                      //                 selectedImage!,
                      //                 fit: BoxFit.fill,
                      //                 width: 100,
                      //                 height: 100,
                      //               )
                      //             : Image.asset(
                      //                 'assets/images/member.png',
                      //                 fit: BoxFit.fill,
                      //                 width: 100,
                      //                 height: 100,
                      //               )),
                      //   ),
                      // ),
                      const Spacer(),
                      _textFielView(size, "First Name", "", firstName),
                      // const SizedBox(
                      //   height: 25,
                      // ),
                      _textFielView(size, 'Last Name', "", lastName),
                      // const SizedBox(
                      //   height: 25,
                      // ),
                      // const Spacer(),
                      _textFielView(size, "username", "", userName),
                      // const SizedBox(
                      //   height: 25,
                      // ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: size.height * .01),
                          child: TextFormField(
                            readOnly: true,
                            controller: email,
                            keyboardType: TextInputType.phone,
                            cursorHeight: 25,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: appBarColor,
                            ),
                            cursorColor: appBarColor,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: "Email",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white)),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 25,
                      // ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: size.height * .01),
                          child: TextFormField(
                            readOnly: true,
                            controller: pass,
                            obscureText: true,
                            keyboardType: TextInputType.phone,
                            cursorHeight: 25,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: appBarColor,
                            ),
                            cursorColor: appBarColor,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: "Password",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white)),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 26,
                      // ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: size.height * .01),
                          child: TextFormField(
                            controller: instaId,
                            keyboardType: TextInputType.text,
                            cursorHeight: 25,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: appBarColor,
                            ),
                            cursorColor: appBarColor,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: "Insta id (Optional)",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white)),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 26,
                      // ),
                      // const Spacer(),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * .39,
                              child: ListTile(
                                title: Text(
                                  "Male",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                leading: Radio(
                                  activeColor: Colors.white,
                                  groupValue: val,
                                  value: "M",
                                  onChanged: ((value) {
                                    setState(() {
                                      val = value as String;
                                    });
                                  }),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * .46,
                              child: ListTile(
                                title: Text(
                                  "Female",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                leading: Radio(
                                  activeColor: Colors.white,
                                  groupValue: val,
                                  value: "F",
                                  onChanged: ((value) {
                                    setState(() {
                                      val = value as String;
                                    });
                                  }),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // _textFielView(size, "Gender", "", gender),
                      // const SizedBox(
                      //   height: 25,
                      // ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: size.height * .01),
                          child: TextFormField(
                            //Todo : add initial value
                            controller: phoneNo,
                            keyboardType: TextInputType.phone,
                            cursorHeight: 25,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: appBarColor,
                            ),
                            validator: (e) {
                              print("kls");
                              if (e!.length != 10) {
                                return "There should be 10 digits ...";
                              }
                              return null;
                            },
                            cursorColor: appBarColor,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: "Phone Number",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.white)),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .02,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate() &&
                                val.isNotEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return WillPopScope(
                                        child: LoadingData(),
                                        onWillPop: () async {
                                          return false;
                                        });
                                  });
                              PostUserModel newUser = PostUserModel(
                                  password: pass.text,
                                  firstName: firstName.text,
                                  lastName: lastName.text,
                                  firebase: fbId,
                                  name: userName.text,
                                  gender: val,
                                  phone: phoneNo.text,
                                  chatAllowed: true,
                                  chatReports: 0,
                                  email: email.text,
                                  score: 0,
                                  instagramId: instaId.text,
                                  profileImage: val == "M"
                                      ? "https://th.bing.com/th/id/OIP.cDzYQ0dIsQvWieDUHI9gXQHaHa?pid=ImgDet&rs=1"
                                      : "https://cdn3.iconfinder.com/data/icons/business-avatar-1/512/4_avatar-512.png");
                              bool isPosted = await postUser(newUser);
                              if (isPosted) {
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => BottomNav())),
                                    (route) => false);
                                RestartWidget.restartApp(context);
                              } else {
                                Navigator.pop(context);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              maximumSize: const Size(300, 50),
                              backgroundColor:
                                  const Color.fromARGB(255, 184, 151, 213),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          child: Center(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.height * .02,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _textFielView(Size size, String hintText, String initialValue,
      TextEditingController textEditingController) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * .01),
        child: TextField(
          //Todo : add initial value
          controller: textEditingController,
          cursorHeight: 25,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: appBarColor,
          ),
          cursorColor: appBarColor,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(width: 0, color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(width: 0, color: Colors.white)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 25),
            filled: true,
            fillColor: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}

Future<bool> postUser(PostUserModel newUser) async {
  try {
    var url = Uri.parse(postUserUrl);
    var response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: postUserModelToJson(newUser));
    if (response.statusCode == 201) {
      //auth token genration
      var tokenUrl = Uri.parse(refreshTokenUrl);
      Map<String, String> body = {
        'email': newUser.email,
        'password': newUser.password
      };
      var tokens = await http.post(tokenUrl, body: body);
      TokensModel authTokens = tokensModelFromJson(tokens.body);
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('presentUser', response.body);
      sharedPreferences.setBool("isuserdatapresent", true);
      sharedPreferences.setString("refreshToken", authTokens.refresh);
      sharedPreferences.setString("password", newUser.password);
      Globals.isuserhavedata = true;
      return true;
    } else {
      var data = json.decode(response.body);

      if (data["Errors:"]["name"][0] ==
          "user with this username already exists.") {
        Utils.showSnackBar("Username already exits!!!");
        return false;
      } else if (data["Errors:"]["name"][0] == "This field may not be blank.") {
        Utils.showSnackBar("Enter username!!!");
        return false;
      }
      Utils.showSnackBar(response.body);
    }
  } catch (e) {
    // Utils.showSnackBar(e.toString());
    // print(e.toString());
  }
  return false;
}
