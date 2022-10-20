// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/models/user_model.dart';
import 'package:hillfair2022_frontend/screens/profile/edit_profile.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'dart:io';
//import 'package:hillfair2022_frontend/profile/postuser.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  UserModel presentUser = UserModel(
      firstName: "no data",
      lastName: "no data",
      firebase: "no data",
      name: "no data",
      gender: "no data",
      phone: "no data",
      chatAllowed: true,
      chatReports: 0,
      email: "no data",
      score: 0,
      instagramId: "no data",
      profileImage: "no data");

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainUserData = sharedPreferences.getString('presentUser');
    presentUser = userModelFromJson(obtainUserData!);
    if (presentUser != null) {}
    setState(() {
      presentUser = userModelFromJson(obtainUserData);
    });
    print(obtainUserData);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return _profileView(size, context);
  }

  Container _profileView(Size size, BuildContext context) {
    getValidationData();

    return Container(
        color: bgColor,
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //   image: AssetImage("assets/images/bg.png"),
        //   fit: BoxFit.fill,
        // )),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("Profile",
                style: TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 23,
                  ),
                  Container(
                    width: size.width * .8,
                    height: size.height * .5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 18,
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/member.png'),
                        ),
                        SizedBox(
                          height: 15.75,
                        ),
                        Text(presentUser.name,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: size.height * .02,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 12,
                        ),
                        Text(presentUser.email,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: size.height * .02,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 12,
                        ),
                        Text("roll",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: size.height * .02,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 12,
                        ),
                        Text(presentUser.phone,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: size.height * .02,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 12,
                        ),
                        Text(presentUser.instagramId,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: size.height * .02,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => EditProfile()));
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(120, 35),
                              backgroundColor:
                                  Color.fromARGB(255, 184, 151, 213),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          child: Center(
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                      SizedBox(
                        width: 17,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            //TO Add a function to save the user details
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(120, 35),
                              backgroundColor:
                                  Color.fromARGB(255, 184, 151, 213),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          child: Center(
                            child: Text(
                              "Log Out",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                    ],
                  )
                ]),
          ),
        ));
  }
}
