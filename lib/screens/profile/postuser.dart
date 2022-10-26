import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../models/postUser_model.dart';
import '../../utils/api_constants.dart';
import '../../utils/snackbar.dart';
import '../bottomnav/nav.dart';

class PostUser extends StatefulWidget {
  var email;
  // String fbId;
  // String password;

  PostUser(this.email, {super.key});

  @override
  State<PostUser> createState() => _PostUserState();
}

class _PostUserState extends State<PostUser> {
  File? selectedImage;
  String base64Image = "";
  
  Future chooseImage() async {
    var image;

    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
      });
    }
  }

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final userName = TextEditingController();
  final rollNo = TextEditingController();
  final gender = TextEditingController();
  final instaId = TextEditingController();

  final phoneNo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String fbId = FirebaseAuth.instance.currentUser!.uid;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/bg.png"),
        fit: BoxFit.fill,
      )),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    chooseImage();
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                        child: selectedImage != null
                            ? Image.file(
                                selectedImage!,
                                fit: BoxFit.fill,
                                width: 100,
                                height: 100,
                              )
                            : Image.asset(
                                'assets/images/member.png',
                                fit: BoxFit.fill,
                                width: 100,
                                height: 100,
                              )),
                  ),
                ),
                const Spacer(),
                _textFielView("First Name", "", firstName),
                // const SizedBox(
                //   height: 25,
                // ),
                _textFielView('Last Name', "", lastName),
                // const SizedBox(
                //   height: 25,
                // ),
                // const Spacer(),
                _textFielView("username", "", userName),
                // const SizedBox(
                //   height: 25,
                // ),
                _textFielView("email", "", email),
                // const SizedBox(
                //   height: 25,
                // ),
                _textFielView('Roll number', "", rollNo),
                // const SizedBox(
                //   height: 26,
                // ),
                _textFielView("Insta_Id", "", instaId),
                // const SizedBox(
                //   height: 26,
                // ),
                // const Spacer(),
                _textFielView("Gender", "", gender),
                // const SizedBox(
                //   height: 25,
                // ),
                _textFielView('Phone Number', "", phoneNo),
                // const SizedBox(
                //   height: 50,
                // ),
                ElevatedButton(
                    onPressed: () async {
                      String fbId = FirebaseAuth.instance.currentUser!.uid;
                      PostUserModel newUser = PostUserModel(
                          password: "password", //TODO: PASSWORD ....?>>>
                          firstName: firstName.text,
                          lastName: lastName.text,
                          firebase: fbId,
                          name: userName.text,
                          gender: gender.text,
                          phone: phoneNo.text,
                          chatAllowed: true,
                          chatReports: 0,
                          email: email.text,
                          score: 0,
                          instagramId: "instagramId",
                          profileImage: "https://placekitten.com/250/250");
                      bool isPosted = await postUser(newUser);
                      if (isPosted) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomNav()));
                      } else {
                        //TODO: same page again
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        maximumSize: const Size(300, 50),
                        backgroundColor:
                            const Color.fromARGB(255, 184, 151, 213),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size.height * .02,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField _textFielView(String hintText, String initialValue,
      TextEditingController textEditingController) {
    return TextField(
      //Todo : add initial value
      controller: textEditingController,
      cursorHeight: 25,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: appBarColor,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      cursorColor: appBarColor,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(width: 0, color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(width: 0, color: Colors.white)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 25),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}

Future<bool> postUser(PostUserModel newUser) async {
  try {
    var url = Uri.parse(postUserUrl);
    var response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: postUserModelToJson(newUser));
    if (response.statusCode == 201) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('presentUser', response.body);
      Utils.showSnackBar("User_creaated !..");
      return true;
    } else {
      // TODO: error handling
      Utils.showSnackBar(response.body);
    }
  } catch (e) {
    Utils.showSnackBar(e.toString());
    print(e.toString());
  }
  return false;
}
