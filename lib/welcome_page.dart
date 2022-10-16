import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signup_widget.dart';
import 'sign_in.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
        )),
        child: Center(
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
              const SizedBox(height: 275),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 60),
                      backgroundColor: const Color.fromARGB(255, 184, 151, 213),
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
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.bold,fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 23,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 60),
                      backgroundColor: const Color.fromARGB(255, 66, 57, 140),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => SignUpWidget(
                              onClickedSignIn: () {},
                            )),
                      ),
                    );
                  },
                  
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
