import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/models/postUser_model.dart';
import 'package:hillfair2022_frontend/main.dart';
import 'package:hillfair2022_frontend/screens/bottomnav/nav.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/api_constants.dart';
import '../../utils/snackbar.dart';

class EditProfile extends StatefulWidget {
  String userPassword;
  String fbId;
  String email;

  EditProfile(this.userPassword, this.fbId, this.email, {super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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

  final name = TextEditingController();

  final email = TextEditingController();

  final rollNo = TextEditingController();

  final instaId = TextEditingController();

  final gender = TextEditingController(); //TODO: use for gender

  final phoneNo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        height: size.height,
        color: bgColor,
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //   image: AssetImage("assets/images/bg.png"),
        //   fit: BoxFit.fill,
        // )),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .1),
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
                TextField(
                  controller: name,
                  cursorHeight: 25,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: appBarColor,
                  ),
                  cursorColor: appBarColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: email,
                  cursorHeight: 25,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: appBarColor,
                  ),
                  cursorColor: appBarColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Email address',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: rollNo,
                  cursorHeight: 25,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: appBarColor,
                  ),
                  cursorColor: appBarColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Roll number',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                TextField(
                  controller: instaId,
                  cursorHeight: 25,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: appBarColor,
                  ),
                  cursorColor: appBarColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Instagram Id',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                TextField(
                  controller: phoneNo,
                  cursorHeight: 25,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: appBarColor,
                  ),
                  cursorColor: appBarColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      PostUserModel newUser = PostUserModel(
                          password: widget.userPassword,
                          firstName: "firstName",
                          lastName: "lastName",
                          firebase: widget.fbId,
                          name: name.text,
                          gender: gender.text,
                          phone: phoneNo.text,
                          chatAllowed: true,
                          chatReports: 0,
                          email: email.text,
                          score: 0,
                          instagramId: "instagramId",
                          profileImage: "https://placekitten.com/250/250");
                      editUserInfo(newUser);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottomNav()));
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
                            fontSize: size.height * .02,
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
}

editUserInfo(PostUserModel newUser) async {
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
      Utils.showSnackBar("Info Edited !..");
      // TODO: navigate to bottom nav

    } else {
      Utils.showSnackBar("something went wrong");
      //TODO: RE edit the page
    }
  } catch (e) {
    Utils.showSnackBar(e.toString());
    print(e.toString());
  }
}
