// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hillfair2022_frontend/screens/chatting/chatting.dart';
import 'package:hillfair2022_frontend/screens/events/events.dart';
import 'package:hillfair2022_frontend/screens/profile/postuser.dart';
import 'package:hillfair2022_frontend/screens/profile/profile.dart';
import 'package:hillfair2022_frontend/screens/team/teamlist.dart';
import 'package:hillfair2022_frontend/screens/userfeed/tabslider.dart';
import 'package:hillfair2022_frontend/screens/userfeed/userfeed.dart';
import 'package:hillfair2022_frontend/sign_in.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/screens/chatting/chatting.dart';
import 'package:hillfair2022_frontend/utils/global.dart';
import 'package:hillfair2022_frontend/view_models/presentUser.dart';
import 'package:hillfair2022_frontend/view_models/team_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view_models/events_view_model.dart';

import 'package:firebase_auth/firebase_auth.dart';

// ignore_for_file: prefer_const_constructors

import 'package:cloudinary_public/cloudinary_public.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/utils/global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../../models/user_profile/postUser_model.dart';
import '../../utils/api_constants.dart';
import '../../utils/snackbar.dart';
import '../bottomnav/nav.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List navPages = [TeamList(), TabSlider(), Events(), Profile()];

  int currentIndex = 1;
  // late bool ispresentdata;
  // late String? email;
  // late String? pass;

  // data() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   print(preferences.getBool("isuserdatapresent"));
  // }

  // sstate() {
  //   setState(() {});
  // }

  @override
  void initState() {
    // TODO: implement initState
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // ispresentdata = preferences.getBool("isuserdatapresent") as bool;
    // email = preferences.getString("useremail");
    // pass = preferences.getString("userpass");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (Globals.isuserhavedata == true) {
      return Scaffold(
        backgroundColor: bgColor,
        body: navPages[currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.height * .01, horizontal: size.width * .02),
            child: GNav(
                activeColor: bgColor,
                color: Color(0xff525252),
                tabBackgroundColor: Color.fromARGB(255, 196, 189, 215),
                gap: 8,
                selectedIndex: currentIndex,
                onTabChange: (int i) {
                  setState(() {
                    currentIndex = i;
                  });
                },
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                tabs: const [
                  GButton(
                    icon: Icons.group,
                    text: "Teams",
                  ),
                  // GButton(
                  //   icon: CupertinoIcons.chat_bubble_2,
                  //   text: "Chatting",
                  // ),
                  GButton(
                    icon: CupertinoIcons.home,
                    text: "Home",
                  ),
                  GButton(
                    icon: CupertinoIcons.calendar,
                    text: "Events",
                  ),
                  GButton(
                    icon: Icons.person,
                    text: "Profile",
                  ),
                ]),
          ),
        ),
      );
    } else {
      return PostUser(Globals.email, Globals.password);
    }
  }
}

// Widget postuser(String? eemail, String? ppass, Size size, BuildContext context,
//     Function sstate) {
//   String val = "";

//   final firstName = TextEditingController();
//   final lastName = TextEditingController();
//   late final TextEditingController email;
//   late final TextEditingController pass;
//   final userName = TextEditingController();
//   final gender = TextEditingController();
//   final instaId = TextEditingController();
//   final phoneNo = TextEditingController();

//   // @override
//   // void initState() {
//   // Navigator.popUntil(context, (route) => route.isFirst);
//   email = TextEditingController(text: eemail);
//   pass = TextEditingController(text: ppass);
//   // super.initState();
//   // }
//   final _formkey = GlobalKey<FormState>();

//   String fbId = FirebaseAuth.instance.currentUser!.uid;

//   return WillPopScope(
//     onWillPop: (() async {
//       return false;
//     }),
//     child: Scaffold(
//       backgroundColor: bgColor,
//       body: SingleChildScrollView(
//         child: SizedBox(
//           height: size.height,
//           width: size.width,
//           child: Center(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: size.width * .08),
//               child: Form(
//                 key: _formkey,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: size.height * .07,
//                     ),
//                     // will take profile image in edit profile page

//                     // GestureDetector(
//                     //   onTap: () {
//                     //     chooseImage();
//                     //   },
//                     //   child: CircleAvatar(
//                     //     radius: 50,
//                     //     backgroundColor: Colors.white,
//                     //     child: ClipOval(
//                     //         child: selectedImage != null
//                     //             ? Image.file(
//                     //                 selectedImage!,
//                     //                 fit: BoxFit.fill,
//                     //                 width: 100,
//                     //                 height: 100,
//                     //               )
//                     //             : Image.asset(
//                     //                 'assets/images/member.png',
//                     //                 fit: BoxFit.fill,
//                     //                 width: 100,
//                     //                 height: 100,
//                     //               )),
//                     //   ),
//                     // ),
//                     const Spacer(),
//                     _textFielView(size, "First Name", "", firstName),
//                     // const SizedBox(
//                     //   height: 25,
//                     // ),
//                     _textFielView(size, 'Last Name', "", lastName),
//                     // const SizedBox(
//                     //   height: 25,
//                     // ),
//                     // const Spacer(),
//                     _textFielView(size, "username", "", userName),
//                     // const SizedBox(
//                     //   height: 25,
//                     // ),
//                     Expanded(
//                       child: Padding(
//                         padding:
//                             EdgeInsets.symmetric(vertical: size.height * .01),
//                         child: TextFormField(
//                           readOnly: true,
//                           controller: email,
//                           keyboardType: TextInputType.phone,
//                           cursorHeight: 25,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: appBarColor,
//                           ),
//                           cursorColor: appBarColor,
//                           textInputAction: TextInputAction.next,
//                           decoration: InputDecoration(
//                             hintText: "Email",
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25.0),
//                                 borderSide: const BorderSide(
//                                     width: 0, color: Colors.white)),
//                             focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25.0),
//                                 borderSide: const BorderSide(
//                                     width: 0, color: Colors.white)),
//                             errorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25.0),
//                                 borderSide: const BorderSide(
//                                     width: 0, color: Colors.white)),
//                             focusedErrorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25.0),
//                                 borderSide: const BorderSide(
//                                     width: 0, color: Colors.white)),
//                             contentPadding:
//                                 const EdgeInsets.symmetric(horizontal: 25),
//                             filled: true,
//                             fillColor: const Color.fromARGB(255, 255, 255, 255),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // const SizedBox(
//                     //   height: 25,
//                     // ),
//                     _textFielView(size, 'Password', "", pass),
//                     // const SizedBox(
//                     //   height: 26,
//                     // ),
//                     _textFielView(size, "Insta_Id", "", instaId),
//                     // const SizedBox(
//                     //   height: 26,
//                     // ),
//                     // const Spacer(),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             width: size.width * .39,
//                             child: ListTile(
//                               title: Text(
//                                 "Male",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                               leading: Radio(
//                                 activeColor: Colors.white,
//                                 groupValue: val,
//                                 value: "M",
//                                 onChanged: ((value) {
//                                   val = value as String;
//                                   // sstate();
//                                 }),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: size.width * .46,
//                             child: ListTile(
//                               title: Text(
//                                 "Female",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                               leading: Radio(
//                                 activeColor: Colors.white,
//                                 groupValue: val,
//                                 value: "F",
//                                 onChanged: ((value) {
//                                   val = value as String;
//                                   sstate();
//                                 }),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     // _textFielView(size, "Gender", "", gender),
//                     // const SizedBox(
//                     //   height: 25,
//                     // ),
//                     Expanded(
//                       child: Padding(
//                         padding:
//                             EdgeInsets.symmetric(vertical: size.height * .01),
//                         child: TextFormField(
//                           //Todo : add initial value
//                           controller: phoneNo,
//                           keyboardType: TextInputType.phone,
//                           cursorHeight: 25,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: appBarColor,
//                           ),
//                           validator: (e) {
//                             print("kls");
//                             if (e!.length != 10) {
//                               return "There should be 10 digits ...";
//                             }
//                             return null;
//                           },
//                           cursorColor: appBarColor,
//                           textInputAction: TextInputAction.next,
//                           decoration: InputDecoration(
//                             hintText: "Phone Number",
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25.0),
//                                 borderSide: const BorderSide(
//                                     width: 0, color: Colors.white)),
//                             focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25.0),
//                                 borderSide: const BorderSide(
//                                     width: 0, color: Colors.white)),
//                             errorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25.0),
//                                 borderSide: const BorderSide(
//                                     width: 0, color: Colors.white)),
//                             focusedErrorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25.0),
//                                 borderSide: const BorderSide(
//                                     width: 0, color: Colors.white)),
//                             contentPadding:
//                                 const EdgeInsets.symmetric(horizontal: 25),
//                             filled: true,
//                             fillColor: const Color.fromARGB(255, 255, 255, 255),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: size.height * .02,
//                     ),
//                     ElevatedButton(
//                         onPressed: () async {
//                           if (_formkey.currentState!.validate()) {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return WillPopScope(
//                                       child: LoadingData(),
//                                       onWillPop: () async {
//                                         return false;
//                                       });
//                                 });
//                             PostUserModel newUser = PostUserModel(
//                                 password: pass.text, //TODO: PASSWORD ....?>>>
//                                 firstName: firstName.text,
//                                 lastName: lastName.text,
//                                 firebase: fbId,
//                                 name: userName.text,
//                                 gender: val,
//                                 phone: phoneNo.text,
//                                 chatAllowed: true,
//                                 chatReports: 0,
//                                 email: email.text,
//                                 score: 0,
//                                 instagramId: instaId.text,
//                                 profileImage:
//                                     "https://placekitten.com/250/250");
//                             bool isPosted = await postUser(newUser);
//                             if (isPosted) {
//                               // ignore: use_build_context_synchronously
//                               Navigator.pushAndRemoveUntil(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: ((context) => BottomNav())),
//                                   (route) => false);
//                               RestartWidget.restartApp(context);
//                             } else {
//                               //TODO: same page again
//                               Navigator.pop(context);
//                             }
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                             maximumSize: const Size(300, 50),
//                             backgroundColor:
//                                 const Color.fromARGB(255, 184, 151, 213),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25))),
//                         child: Center(
//                           child: Text(
//                             "Save",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: size.height * .02,
//                                 fontFamily: GoogleFonts.poppins().fontFamily,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         )),
//                     const Spacer(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Expanded _textFielView(Size size, String hintText, String initialValue,
//     TextEditingController textEditingController) {
//   return Expanded(
//     child: Padding(
//       padding: EdgeInsets.symmetric(vertical: size.height * .01),
//       child: TextField(
//         //Todo : add initial value
//         controller: textEditingController,
//         cursorHeight: 25,
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           color: appBarColor,
//         ),
//         cursorColor: appBarColor,
//         textInputAction: TextInputAction.next,
//         decoration: InputDecoration(
//           hintText: hintText,
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(25.0),
//               borderSide: const BorderSide(width: 0, color: Colors.white)),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(25.0),
//               borderSide: const BorderSide(width: 0, color: Colors.white)),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 25),
//           filled: true,
//           fillColor: const Color.fromARGB(255, 255, 255, 255),
//         ),
//       ),
//     ),
//   );
// }

// Future<bool> postUser(PostUserModel newUser) async {
//   try {
//     var url = Uri.parse(postUserUrl);
//     var response = await http.post(url,
//         headers: {
//           HttpHeaders.contentTypeHeader: "application/json",
//         },
//         body: postUserModelToJson(newUser));
//     if (response.statusCode == 201) {
//       final SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       sharedPreferences.setString('presentUser', response.body);
//       sharedPreferences.setBool("isuserdatapresent", true);
//       Globals.isuserhavedata = true;
//       // Utils.showSnackBar("User_created !..");
//       return true;
//     } else {
//       // TODO: error handling
//       // Utils.showSnackBar(response.body);
//     }
//   } catch (e) {
//     // Utils.showSnackBar(e.toString());
//     // print(e.toString());
//   }
//   return false;
// }
