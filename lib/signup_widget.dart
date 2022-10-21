// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/api_services/user_services.dart';
import 'package:hillfair2022_frontend/models/postUser_model.dart';
import 'package:hillfair2022_frontend/models/user_model.dart';
import 'package:hillfair2022_frontend/screens/profile/edit_profile.dart';
import 'package:hillfair2022_frontend/screens/profile/postuser.dart';
import 'package:hillfair2022_frontend/utils/snackbar.dart';
import 'api_services/api_status.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;

import 'utils/api_constants.dart';
import 'utils/colors.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final String verifyemail = "@nith.ac.in";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        color: bgColor,
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //   image: AssetImage("assets/images/bg.png"),
        //   fit: BoxFit.cover,
        // )),
        child: Scaffold(
          bottomSheet: Container(
            height: size.height * .15,
            decoration: BoxDecoration(
                color: bgColor,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/loginvector.png"))),
          ),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: true,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                height: size.height * .7,
                child: Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w600,
                            color: loginColor),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    Container(
                      child: Form(
                        key: formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: size.height * .03),
                              SizedBox(
                                width: size.width * .7,
                                // height: 35,
                                child: TextFormField(
                                  cursorColor: appBarColor,
                                  cursorHeight: 25,
                                  style: TextStyle(color: appBarColor),
                                  controller: emailController,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                            width: 0, color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                            width: 0, color: Colors.white)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                            width: 0, color: Colors.white)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                            width: 0, color: Colors.white)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (e) {
                                    if (e![0] == "1") {
                                      if (!RegExp(
                                              r'[1]+[89]+[1-8]+[015]+[0-9]+[0-9]+@nith.ac.in')
                                          .hasMatch(e.toLowerCase())) {
                                      return "Use College Email";
                                      } else {
                                        return null;
                                    }
                                    } else if (e[0] == "2") {
                                      if (!RegExp(
                                              r'[2]+[01]+[bd]+[cemap]+[ecsrha]+[01]+[0-9]+[0-9]+@nith.ac.in')
                                          .hasMatch(e.toLowerCase())) {
                                        return "Use College Email";
                                      } else {
                                        return null;
                                      }
                                    } else {
                                      return "Use College Email";
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: size.height * .03),
                              SizedBox(
                                width: size.width * .7,
                                // height: 35,
                                child: TextFormField(
                                  cursorColor: appBarColor,
                                  cursorHeight: 25,
                                  style: TextStyle(color: appBarColor),
                                  controller: passwordController,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                            width: 0, color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                            width: 0, color: Colors.white)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                            width: 0, color: Colors.white)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                            width: 0, color: Colors.white)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                  obscureText: true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) =>
                                      value != null && value.length < 8
                                          ? 'Enter min. 8 characters'
                                          : null,
                                ),
                              ),
                              SizedBox(height: size.height * .03),
                              SizedBox(
                                width: size.width * .7,
                                // height: 35,
                                child: TextFormField(
                                  cursorColor: appBarColor,
                                  cursorHeight: 25,
                                  style: TextStyle(color: appBarColor),
                                  controller: confirmPasswordController,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    hintText: 'Re-enter Password',
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                            width: 0, color: Colors.white)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                            width: 0, color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                            width: 0, color: Colors.white)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                            width: 0, color: Colors.white)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                  obscureText: true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: ((value) {
                                    if (passwordController.text !=
                                        confirmPasswordController.text) {
                                      return "Password doesn't match";
                                    }
                                    return null;
                                  }),
                                ),
                              ),
                              SizedBox(
                                height: size.height * .05,
                              ),
                              SizedBox(
                                width: size.width * .7,
                                height: size.height * .06,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      splashFactory: NoSplash.splashFactory,
                                      backgroundColor: const Color.fromARGB(
                                          255, 66, 57, 140),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25))),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      signUp();
                                    }
                                  },
                                  child: Center(
                                    child: SizedBox(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              fontSize: size.width * .06,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future signUp() async {
    final isvalid = formKey.currentState!.validate();
    if (!isvalid) return "Error";
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Utils.showSnackBar("An Email is sent to you for verification");
      String email = emailController.text;
      var userId = FirebaseAuth.instance.currentUser!.uid;
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PostUser(email, userId)),
          (route) => false);
      
      // UserModel data = UserModel(
      //     firstName: "John",
      //     lastName: "Doe",
      //     firebase: userId,
      //     name: "Peter Parker",
      //     gender: "M",
      //     phone: "0000000000",
      //     chatAllowed: true,
      //     chatReports: 0,
      //     email: email,
      //     score: 0,
      //     instagramId: "instaId",
      //     profileImage: "https://placekitten.com/250/250");
      //postUser
      // PostUserModel postUserData = PostUserModel(
      //     password: passwordController.text,
      //     firstName: "John",
      //     lastName: "Doe",
      //     firebase: userId,
      //     name: "Peter Parker",
      //     gender: "M",
      //     phone: "0000000000",
      //     chatAllowed: true,
      //     chatReports: 0,
      //     email: email,
      //     score: 0,
      //     instagramId: "instaId",
      //     profileImage: "https://placekitten.com/250/250");

      // var url = Uri.parse(postUserUrl);
      // var response = await http.post(url,
      //     headers: {
      //       HttpHeaders.contentTypeHeader: "application/json",
      //     },
      //     body: postUserModelToJson(postUserData));
      // print(response.statusCode);
      //
//       final SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       if (response.statusCode == postSuccessCode) {
//   sharedPreferences.setString('presentUser', response.body);
// }
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
      // return Future.value("Error");
    }
  }
}
