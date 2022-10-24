// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
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
  String name, email, instaid, phno;

  EditProfile({
    super.key,
    required this.name,
    required this.email,
    required this.instaid,
    required this.phno,
  });

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

  // to be make in use
  Future<File> compressImage({
    required File imagepath,
  }) async {
    var path = await FlutterNativeImage.compressImage(imagepath.absolute.path,
        quality: 100, percentage: 35);
    return path;
  }

  late final name;

  late final email;

  
  late final instaId;
  final pass = TextEditingController();
  late final phoneNo;

  @override
  void initState() {
    instaId = TextEditingController(text: widget.instaid);
    name = TextEditingController(text: widget.name);
    phoneNo = TextEditingController(text: widget.phno);
    email = TextEditingController(text: widget.email);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
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
                SizedBox(
                  height: size.height * .1,
                ),
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
                  controller: pass,
                  cursorHeight: 25,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: appBarColor,
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
