import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

class PostUser extends StatefulWidget {
  String email;
  String fbId;
  String password;

   PostUser(this.email, this.fbId, this.password, {super.key})
  

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

  final rollNo = TextEditingController();
final gender = TextEditingController();
  final instaId = TextEditingController();

  final phoneNo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                TextField(
                  controller: firstName,
                  cursorHeight: 25,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: appBarColor,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                  cursorColor: appBarColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'First Name',
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
                  controller: lastName,
                  cursorHeight: 25,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: appBarColor,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                  cursorColor: appBarColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
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
                const Spacer(),
                TextField(
                  controller: email,
                  cursorHeight: 25,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: appBarColor,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                  cursorColor: appBarColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Email Address',
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
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                  cursorColor: appBarColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                    fontFamily: GoogleFonts.poppins().fontFamily,
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
                    fontFamily: GoogleFonts.poppins().fontFamily,
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
                const Spacer(),
                TextField(
                  controller: gender,
                  cursorHeight: 25,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: appBarColor,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                  cursorColor: appBarColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Gender',
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
                  controller: phoneNo,
                  cursorHeight: 25,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: appBarColor,
                    fontFamily: GoogleFonts.poppins().fontFamily,
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
                    onPressed: () {},
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
}