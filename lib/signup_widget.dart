// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/api_services/user_services.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';
import 'package:hillfair2022_frontend/models/postUser_model.dart';
import 'package:hillfair2022_frontend/models/user_model.dart';
import 'package:hillfair2022_frontend/screens/profile/edit_profile.dart';
import 'package:hillfair2022_frontend/screens/profile/postuser.dart';
import 'package:hillfair2022_frontend/utils/snackbar.dart';
import 'package:hillfair2022_frontend/verify_email_page.dart';
// import 'package:hillfair2022_frontend/verify_email_page.dart';
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
  bool isEmailVerified = false;
  Timer? timer;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  //final String verifyemail = "@nith.ac.in";
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
            child: SizedBox(
                height: size.height * .9,
                width: size.width,
                child: Stack(
                  children: [
                    Positioned(
                      top: size.height * .1,
                      left: 0,
                      right: 0,
                      child: Center(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: size.height * .03),
                                        SizedBox(
                                          width: size.width * .7,
                                          // height: 35,
                                          child: TextFormField(
                                            cursorColor: appBarColor,
                                            cursorHeight: 25,
                                            style:
                                                TextStyle(color: appBarColor),
                                            controller: emailController,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              hintText: 'Email',
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  borderSide: const BorderSide(
                                                      width: 0,
                                                      color: Colors.white)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  borderSide: const BorderSide(
                                                      width: 0,
                                                      color: Colors.white)),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 0,
                                                              color: Colors
                                                                  .white)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  borderSide: const BorderSide(
                                                      width: 0,
                                                      color: Colors.white)),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (e) {
                                              if (e!.isEmpty) {
                                                return "Use College Email";
                                              }
                                              if (e[0] == "1") {
                                                if (!RegExp(
                                                        r'[1]+[89]+[1-8]+[015]+[0-9]+[0-9]+@nith.ac.in')
                                                    .hasMatch(
                                                        e.toLowerCase())) {
                                                  return "Use College Email";
                                                } else {
                                                  return null;
                                                }
                                              } else if (e[0] == "2") {
                                                if (!RegExp(
                                                        r'[2]+[01]+[bd]+[cemap]+[ecsrha]+[01]+[0-9]+[0-9]+@nith.ac.in')
                                                    .hasMatch(
                                                        e.toLowerCase())) {
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
                                            style:
                                                TextStyle(color: appBarColor),
                                            controller: passwordController,
                                            textInputAction:
                                                TextInputAction.done,
                                            decoration: InputDecoration(
                                              hintText: 'Password',
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  borderSide: const BorderSide(
                                                      width: 0,
                                                      color: Colors.white)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  borderSide: const BorderSide(
                                                      width: 0,
                                                      color: Colors.white)),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 0,
                                                              color: Colors
                                                                  .white)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  borderSide: const BorderSide(
                                                      width: 0,
                                                      color: Colors.white)),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                            obscureText: true,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (value) =>
                                                value != null &&
                                                        value.length < 8
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
                                            style:
                                                TextStyle(color: appBarColor),
                                            controller:
                                                confirmPasswordController,
                                            textInputAction:
                                                TextInputAction.done,
                                            decoration: InputDecoration(
                                              hintText: 'Re-enter Password',
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  borderSide: const BorderSide(
                                                      width: 0,
                                                      color: Colors.white)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  borderSide: const BorderSide(
                                                      width: 0,
                                                      color: Colors.white)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  borderSide: const BorderSide(
                                                      width: 0,
                                                      color: Colors.white)),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 0,
                                                              color: Colors
                                                                  .white)),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                            obscureText: true,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: ((value) {
                                              if (passwordController.text !=
                                                  confirmPasswordController
                                                      .text) {
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
                                                splashFactory:
                                                    NoSplash.splashFactory,
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 66, 57, 140),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25))),
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
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
                                                        fontSize:
                                                            size.width * .06,
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
                    Positioned(
                        top: size.height * .75,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          // height: size.height * .03,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      "assets/images/loginvector.png"))),
                        ))
                  ],
                ))));
  }

  Future signUp() async {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: LoadingData());
        });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );


      String email = emailController.text;
      String userId = FirebaseAuth.instance.currentUser!.uid;
      
      final SharedPreferences Email = await SharedPreferences.getInstance();
      Email.setString('email', email);
      // final SharedPreferences Id = await SharedPreferences.getInstance();
      // Id.setString('UserId', userId);
      final SharedPreferences password = await SharedPreferences.getInstance();
      password.setString('password', passwordController.text);
      navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => VerifyEmailPage()),
          (route) => false);

     

     // String email = emailController.text;
     // var userId = FirebaseAuth.instance.currentUser!.uid;
     // navigatorKey.currentState!.pushAndRemoveUntil(
     //     MaterialPageRoute(
      //        builder: (context) =>
       //           PostUser(email, userId, passwordController.text)),
       //   (route) => false);

    } on FirebaseAuthException catch (e) {
      navigatorKey.currentState!.pop();
      print(e);
      Utils.showSnackBar(e.message);
    }
  }
}
