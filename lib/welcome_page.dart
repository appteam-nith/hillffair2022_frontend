import 'package:flutter/material.dart';
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
              ElevatedButton.icon(
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
                  icon: const Icon(
                    Icons.lock_open,
                    size: 32,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'Sign In',
                    style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w600),
                  )),
              const SizedBox(
                height: 23,
              ),
              ElevatedButton.icon(
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
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 32,
                  ),
                  label: const Text(
                    'Sign Up',
                    style: TextStyle(
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
