// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'signup_widget.dart';
import 'sign_in.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      bottomSheet: Container(
        height: size.height * .15,
        decoration: BoxDecoration(
            color: bgColor,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/loginvector.png"))),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 117),
              child: const Center(
                child: Text(
                  "WELCOME",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * .35),
            SizedBox(
              width: size.width * .75,
              height: size.height * .06,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: btnColor2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => SignIn(
                            onClickedSignUp: () {},
                          )),
                    ),
                  );
                },
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      fontSize: size.width * .05,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            SizedBox(
              width: size.width * .75,
              height: size.height * .06,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: btnColor1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: ((context) => SignUpWidget())),
                  );
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: size.width * .05, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
