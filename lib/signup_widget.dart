// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/models/user_model.dart';
import 'package:hillfair2022_frontend/screens/profile/edit_profile.dart';
import 'package:hillfair2022_frontend/utils/snackbar.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'utils/colors.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
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
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
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
                            color: Colors.white),
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
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      color: appBarColor),
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
                                    if (!e!.endsWith(verifyemail)) {
                                      return "Use College Email";
                                    }
                                    return null;
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
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      color: appBarColor),
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
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      color: appBarColor),
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

      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      String email = emailController.text;
      var userId = FirebaseAuth.instance.currentUser!.uid;
      UserModel data = UserModel(
          firstName: "rere",
          lastName: "eded",
          firebase: userId,
          name: "nini",
          gender: "male",
          phone: "1234567890",
          chatAllowed: true,
          chatReports: 0,
          email: email,
          score: 0,
          instagramId: "wewewe@id",
          profileImage: "jkdcksdmcsodkcnjdclj");
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('presentUser', userModelToJson(data));
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
      // return Future.value("Error");
    }
  }
}
