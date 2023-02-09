import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/screens/bottomnav/nav.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/utils/global.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  String? password;
  String? email;
  // String? userId;

  getData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // email = prefs.getString('email');
    // password = prefs.getString('password');
    // print(email);
    // print(password);
    email = Globals.email;
    password = Globals.password;
  }

  @override
  initState() {
    super.initState();
    getData();
    var user = FirebaseAuth.instance.currentUser!;
    isEmailVerified = user.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
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
      // Utils.showSnackBar(e.toString());
      // print(e);
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    if (!mounted) return;
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => BottomNav())),
          (route) => false);
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                    "A verification email has been sent to your College Email.",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: size.width * .5,
                        height: size.height * .05,
                        child: ElevatedButton(
                            onPressed:
                                canResendEmail ? sendVerificationEmail : null,
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
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            )),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: size.width * .3,
                        height: size.height * .05,
                        child: TextButton(
                      onPressed: (() async {
                        await FirebaseAuth.instance.signOut();
                      }),
                          style: ElevatedButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                              backgroundColor:
                                  const Color.fromARGB(255, 66, 57, 140),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
