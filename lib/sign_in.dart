// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';
import 'package:hillfair2022_frontend/signup_widget.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/utils/snackbar.dart';
import 'main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'forgot_password_page.dart';

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

    return Container(
        color: bgColor,
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // const SizedBox(height: 40),
                            Container(
                              width: size.width * .7,
                              // height: size.height * .07,
                              // color: Colors.black,
                              child: TextFormField(
                                validator: (e) {
                                  if (!e!.endsWith(verifyemail)) {
                                    return "Use College Email";
                                  }
                                  return null;
                                },
                                controller: emailController,
                                cursorColor: appBarColor,
                                cursorHeight: 25,
                                style: TextStyle(
                                    color: appBarColor),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Email',
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
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
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
                                style: TextStyle(
                                    color: appBarColor),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Password',
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
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
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
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: ((context) => const Center(
                                            child: LoadingData(),
                                          )));
                                  if (formKey.currentState!.validate()) {
                                    signIn();
                                  }
                                  Navigator.pop(context);
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
                              onTap: (() =>
                                  Navigator.of(context).push(MaterialPageRoute(
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
                                          decoration: TextDecoration.underline,
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
        ));
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      Map data = {
        'email': emailController.text.toString(),
        'password': passwordController.text.toString(),
      };
      //signInviewMode.getSingedInUser(data, context);
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
  }
}
