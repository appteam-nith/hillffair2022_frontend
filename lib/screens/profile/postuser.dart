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
  String fbId;
  String password;

  PostUser(this.email, this.fbId,this.password, {super.key});

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
  late final TextEditingController email;
  final userName = TextEditingController();
  final rollNo = TextEditingController();
  final gender = TextEditingController();
  final instaId = TextEditingController();
  final phoneNo = TextEditingController();

  @override
  void initState() {
    email = TextEditingController(text: widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: (() async {
        return false;
      }),
      child: Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: SizedBox(
            height: size.height * .9,
            width: size.width,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * .07,
                    ),
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
                    _textFielView(size, "First Name", "", firstName),
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    _textFielView(size, 'Last Name', "", lastName),
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    // const Spacer(),
                    _textFielView(size, "username", "", userName),
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    _textFielView(size, "email", "", email),
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    // _textFielView(size, 'Roll number', "", rollNo),
                    // const SizedBox(
                    //   height: 26,
                    // ),
                    _textFielView(size, "Insta_Id", "", instaId),
                    // const SizedBox(
                    //   height: 26,
                    // ),
                    // const Spacer(),
                    _textFielView(size, "Gender", "", gender),
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    _textFielView(size, 'Phone Number', "", phoneNo),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          PostUserModel newUser = PostUserModel(
                              password: "password", //TODO: PASSWORD ....?>>>
                              firstName: firstName.text,
                              lastName: lastName.text,
                              firebase: widget.fbId,
                              name: userName.text,
                              gender: gender.text,
                              phone: phoneNo.text,
                              chatAllowed: true,
                              chatReports: 0,
                              email: email.text,
                              score: 0,
                              instagramId: instaId.text,
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
        ),
      ),
    );
  }

  Padding _textFielView(Size size, String hintText, String initialValue,
      TextEditingController textEditingController) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * .01),
      child: TextField(
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
      Utils.showSnackBar("User_created !..");
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
