// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/main.dart';
import 'package:hillfair2022_frontend/models/user_model.dart';
import 'package:hillfair2022_frontend/screens/profile/edit_profile.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/welcome_page.dart';
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
    print(obtainUserData);
    presentUser = userModelFromJson(obtainUserData!);
    // if (presentUser != null) {}
    setState(() {
      // presentUser = userModelFromJson(obtainUserData);
    });
    print(obtainUserData);
  }

  @override
  void initState() {
    // TODO: implement initState
    getValidationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return _profileView(size, context);
  }

  Scaffold _profileView(Size size, BuildContext context) {
    print(presentUser.name);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      backgroundColor: bgColor,
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                backgroundColor: appBarColor,
                radius: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: CachedNetworkImage(
                    imageUrl: presentUser.profileImage,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: imageProvider,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      )),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                )),
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
                // Text("roll",
                //     maxLines: 3,
                //     overflow: TextOverflow.ellipsis,
                //     style: TextStyle(
                //         fontSize: size.height * .02,
                //         fontWeight: FontWeight.bold)),
                // SizedBox(
                //   height: 12,
                // ),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfile(presentUser: presentUser,
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(120, 35),
                      backgroundColor: Color.fromARGB(255, 184, 151, 213),
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
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();

                    // do not clear the instance of present user
                    // SharedPreferences preferences =
                    //     await SharedPreferences.getInstance();
                    // await preferences.clear();
                    navigatorKey.currentState!.pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                        (route) => false);

                    RestartWidget.restartApp(context);

                    //TO Add a function to save the user details
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(120, 35),
                      backgroundColor: Color.fromARGB(255, 184, 151, 213),
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
    );
  }
}
