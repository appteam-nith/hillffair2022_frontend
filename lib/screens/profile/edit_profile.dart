import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/main.dart';
import 'package:hillfair2022_frontend/screens/bottomnav/nav.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

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

  final phoneNo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: bgColor,
      // decoration: const BoxDecoration(
      //     image: DecorationImage(
      //   image: AssetImage("assets/images/bg.png"),
      //   fit: BoxFit.fill,
      // )),
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
                      Navigator.pushReplacement(context,
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
                            color: Colors.black,
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
