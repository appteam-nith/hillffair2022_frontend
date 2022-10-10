import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hillfair2022_frontend/screens/profile/edit_profile.dart';
import 'utils.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

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
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assests/bgN 1.jpg"),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 116,
                ),
                const SizedBox(
                  width: 175,
                  height: 72,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  child: Form(
                    key: formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          SizedBox(
                            width: 260,
                            height: 35,
                            child: TextFormField(
                              controller: emailController,
                              cursorColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                        width: 0, color: Colors.white)),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 26),
                          SizedBox(
                            width: 260,
                            height: 35,
                            child: TextFormField(
                              controller: passwordController,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                        width: 0, color: Colors.white)),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 255, 255, 255),
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
                          const SizedBox(height: 26),
                          SizedBox(
                            width: 260,
                            height: 35,
                            child: TextFormField(
                              controller: confirmPasswordController,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: 'Re-enter Password',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                        width: 0, color: Colors.white)),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 255, 255, 255),
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
                          const SizedBox(
                            height: 41,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                maximumSize: const Size(260, 40),
                                backgroundColor:
                                    const Color.fromARGB(255, 66, 57, 140),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            onPressed: signUp,
                            child: const Center(
                              child: SizedBox(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
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
        ));
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditProfile()));
  }
}
