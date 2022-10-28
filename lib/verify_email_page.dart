import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/screens/bottomnav/nav.dart';
import 'package:hillfair2022_frontend/screens/profile/postuser.dart';
import 'package:hillfair2022_frontend/signUp_widget.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';

import 'package:hillfair2022_frontend/utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:hillfair2022_frontend/utils.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  String? email;
  // String? userId;
  late String password;
  getData() async {
    final SharedPreferences Email = await SharedPreferences.getInstance();
    email = Email.getString('email');
    final SharedPreferences pass = await SharedPreferences.getInstance();
    password = pass.getString('password')!;
  }

  @override
  initState() {
    super.initState();
    getData();
    var user = FirebaseAuth.instance.currentUser!;
    isEmailVerified = user.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      // Utils.showSnackBar('A email Has been sent.Please check your spam folder');
    }
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    if (!mounted) return;
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? PostUser(email, password)
      : Container(
          color: bgColor,
          child: Scaffold(
            bottomSheet: Container(
              height: MediaQuery.of(context).size.height * .15,
              decoration: const BoxDecoration(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'A verification email has been sent to your Email.\n      kindly check your spam folder',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                      onPressed: canResendEmail ? sendVerificationEmail : null,
                      style: ElevatedButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          backgroundColor:
                              const Color.fromARGB(255, 66, 57, 140),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: const Text(
                        'Resent Email',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  TextButton(
                    onPressed: (() => FirebaseAuth.instance.signOut()),
                    style: ElevatedButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                        backgroundColor: const Color.fromARGB(255, 66, 57, 140),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 24),
                    ),
                  )
                ],
              ),
            ),
          ));
}
