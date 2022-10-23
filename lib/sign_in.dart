// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';
import 'package:hillfair2022_frontend/screens/bottomnav/nav.dart';
import 'package:hillfair2022_frontend/signup_widget.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/utils/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'forgot_password_page.dart';
import 'utils/api_constants.dart';

class SignIn extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const SignIn({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: size.height,
                  color: bgColor,
                  child: Center(
                    child: SizedBox(
                      height: size.height * .75,
                      child: Column(
                        children: [
                          Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w600,
                                color: loginColor),
                          ),
                          SizedBox(
                            height: size.height * .1,
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // const SizedBox(height: 40),
                                  Container(
                                    width: size.width * .7,
                                    // height: size.height * .07,
                                    // color: Colors.black,
                                    child: TextFormField(
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
                                      controller: emailController,
                                      cursorColor: appBarColor,
                                      cursorHeight: 25,
                                      style: TextStyle(color: appBarColor),
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
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            borderSide: const BorderSide(
                                                width: 0, color: Colors.white)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            borderSide: const BorderSide(
                                                width: 0, color: Colors.white)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 15),
                                        filled: true,
                                        fillColor: const Color.fromARGB(
                                            255, 255, 255, 255),
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                  ),
                                  SizedBox(height: size.height * .02),
                                  Container(
                                    width: size.width * .7,
                                    // height: size.height * .07,
                                    // color: Colors.black,
                                    child: TextFormField(
                                      validator: (e) {
                                        if (e!.length < 8) {
                                          return "Password should be of 8 character";
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                      cursorHeight: 25,
                                      controller: passwordController,
                                      cursorColor: appBarColor,
                                      style: TextStyle(color: appBarColor),
                                      textInputAction: TextInputAction.next,
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
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            borderSide: const BorderSide(
                                                width: 0, color: Colors.white)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            borderSide: const BorderSide(
                                                width: 0, color: Colors.white)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 15),
                                        filled: true,
                                        fillColor: const Color.fromARGB(
                                            255, 255, 255, 255),
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 39,
                                  ),
                                  SizedBox(
                                    width: size.width * .7,
                                    height: size.height * .06,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          splashFactory: NoSplash.splashFactory,
                                          backgroundColor: btnColor2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25))),
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          await signIn();
                                        }
                                      },
                                      child: Center(
                                        child: SizedBox(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'Sign In',
                                              style: TextStyle(
                                                  fontSize: size.width * .06,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * .02,
                                  ),
                                  GestureDetector(
                                    onTap: (() => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPasswordPage(),
                                        ))),
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: loginColor,
                                          fontSize: size.width * .05,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 110,
                                  ),
                                  RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: loginColor,
                                              fontSize: size.width * .05,
                                              fontWeight: FontWeight.w700),
                                          text: 'Don’t have an account? ',
                                          children: [
                                        TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            SignUpWidget())));
                                              },
                                            text: 'Sign Up',
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: loginColor,
                                                fontSize: size.width * .05))
                                      ]))
                                ]),
                          ),
                        ],
                      ),
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
                            image:
                                AssetImage("assets/images/loginvector.png"))),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return LoadingData();
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Map data = {
        'email': emailController.text.toString(),
        'password': passwordController.text.toString(),
      };

      String email = emailController.text;
      var url = Uri.parse("$checkUserUrl$email");
      var response = await http.get(url);
      if (200 == response.statusCode) {
        SharedPreferences userPrefs = await SharedPreferences.getInstance();
        if (userPrefs.containsKey("presentUser")) {
          userPrefs.remove("presentUser");
        }
        userPrefs.setString("presentUser", response.body);
      } else {
        Utils.showSnackBar(response.body);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      navigatorKey.currentState!.pop();
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: ((context) => BottomNav())),
          (route) => false);
  }
}
