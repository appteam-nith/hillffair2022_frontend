// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/api_services/auth_services.dart';
import 'package:hillfair2022_frontend/main.dart';
import 'package:hillfair2022_frontend/screens/bottomnav/nav.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/loading_data.dart';
import '../../models/tokens/accTokenModel.dart';
import '../../models/user_profile/user_model.dart';
import '../../utils/api_constants.dart';
import '../../utils/global.dart';
import '../../utils/snackbar.dart';

class EditProfile extends StatefulWidget {
  UserModel presentUser;

  EditProfile({super.key, required this.presentUser});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final cloudinary = CloudinaryPublic('dugwczlzo', 'nql7r9cr', cache: false);
  File? selectedImage;
  bool isselectedImage = true;

  Future _pickimage(ImageSource source) async {
    selectedImage = null;
    try {
      final image = await ImagePicker().pickImage(source: source);
      print(image);
      if (image == null) {
        isselectedImage = false;
        return;
      }
      File? img = File(image.path);

      print(img.lengthSync() ~/ 1024);
      if (img.lengthSync() ~/ 1024 <= 10000) {
        setState(() {
          selectedImage = img;
        });
      } else {
        isselectedImage = true;
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //TODO: compress before
  Future<String> getImgUrl(var image) async {
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      print(e.message);
      print(e.request);
      return "";
    }
  }

  // to be make in use
  Future<File> compressImage({
    required File? imagepath,
  }) async {
    var path = await FlutterNativeImage.compressImage(imagepath!.absolute.path,
        quality: 100, percentage: 20);
    return path;
  }

  late final TextEditingController phoneNo;
  late final TextEditingController name;
  late final TextEditingController instaId;
  // late final TextEditingController pass;
  final _formkey = GlobalKey<FormState>();
  String photourl = "";

  @override
  void initState() {
    instaId = TextEditingController(text: widget.presentUser.instagramId);
    name = TextEditingController(text: widget.presentUser.name);
    phoneNo = TextEditingController(text: widget.presentUser.phone);
    // pass = TextEditingController();
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
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    // color: Colors.red,
                    height: size.height * .2,
                    child: Stack(
                      children: [
                        Positioned(
                          // top: size.height*.03,
                          left: size.width * .2,
                          child: Container(
                            alignment: Alignment.center,
                            // color: Colors.black,
                            child: GestureDetector(
                              onTap: () async {
                                await _pickimage(ImageSource.gallery);
                                if (selectedImage == null &&
                                    isselectedImage == true) {
                                  Utils.showSnackBar(
                                      "Image size should less than 10 MB!!!");
                                }
                              },
                              child: CircleAvatar(
                                radius: 70,
                                // backgroundColor: Colors.white,
                                child: ClipOval(
                                    child: selectedImage != null
                                        ? Image.file(
                                            selectedImage!,
                                            fit: BoxFit.cover,
                                            width: 140,
                                            height: 140,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl:
                                                widget.presentUser.profileImage,
                                            imageBuilder:
                                                ((context, imageProvider) {
                                              return Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                image: imageProvider,
                                                alignment: Alignment.center,
                                                fit: BoxFit.cover,
                                              )));
                                            }),
                                            placeholder: (context, url) {
                                              return LoadingData();
                                            },
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          )),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: size.height * .11,
                          left: size.width * .46,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.white),
                              child: IconButton(
                                  splashRadius: 1,
                                  onPressed: () async {
                                    await _pickimage(ImageSource.gallery);
                                    if (selectedImage == null &&
                                        isselectedImage == true) {
                                      Utils.showSnackBar(
                                          "Image size should less than 10 MB!!!");
                                    }
                                  },
                                  icon: Icon(
                                    Icons.photo_camera,
                                    size: 25,
                                    color: bgColor,
                                    // color: Color.fromARGB(255, 184, 151, 213),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  TextFormField(
                    controller: name,
                    cursorHeight: 25,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: appBarColor,
                    ),
                    validator: (e) {
                      if (e!.isEmpty) {
                        return "Enter name...";
                      }
                      return null;
                    },
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
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              const BorderSide(width: 0, color: Colors.white)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              const BorderSide(width: 0, color: Colors.white)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 25),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue: widget.presentUser.email,
                    cursorHeight: 25,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 25),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  TextFormField(
                    controller: instaId,
                    cursorHeight: 25,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: appBarColor,
                    ),
                    cursorColor: appBarColor,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Instagram Id (Optional)',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              const BorderSide(width: 0, color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              const BorderSide(width: 0, color: Colors.white)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              const BorderSide(width: 0, color: Colors.white)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              const BorderSide(width: 0, color: Colors.white)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 25),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  TextFormField(
                    controller: phoneNo,
                    cursorHeight: 25,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.phone,
                    validator: (e) {
                      if (e!.length != 10) {
                        return "There should be 10 digits ...";
                      }
                      return null;
                    },
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
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              const BorderSide(width: 0, color: Colors.white)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              const BorderSide(width: 0, color: Colors.white)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 25),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        // To do -> when user does not choose any profile image
                        // if(selectedImage==null){
                        //   return
                        // }
                        if (_formkey.currentState!.validate()) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return WillPopScope(
                                    child: LoadingData(),
                                    onWillPop: () async {
                                      return false;
                                    });
                              });
                          String photourl = widget.presentUser.profileImage;
                          if (selectedImage != null) {
                            File compressedImage =
                                await compressImage(imagepath: selectedImage);
                            photourl = await getImgUrl(compressedImage);
                          }

                          String editInfo = jsonEncode(<String, String>{
                            "name": name.text,
                            "phone": phoneNo.text,
                            "instagramId": instaId.text,
                            "profileImage": photourl
                          });

                          bool isUpdated = await editUserInfo(
                              editInfo, widget.presentUser.firebase);

                          if (isUpdated) {
                            // RestartWidget.restartApp(context);
                            navigatorKey.currentState!.pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => BottomNav()),
                                (route) => false);
                          } else {
                            Navigator.pop(context);
                          }
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
      ),
    );
  }
}

Future<bool> editUserInfo(String editInfo, String fbId) async {
  try {
    // Map<String, String> header =await AuthServices.getAuthHeader();
          var acTokenUrl = Uri.parse(accessTokenUrl);
      Map<String, String> accessBody = {"refresh": Globals.authToken};
      var accessTokenRes = await http.post(acTokenUrl, body: accessBody);
      AccessTokenModel accessToken = accessTokenModelFromJson(accessTokenRes.body);

      //Authorization header
      Map<String, String> header = {'Authorization': "Bearer ${accessToken.access}",'Content-Type': 'application/json; charset=UTF-8'};
    var url = Uri.parse("$postUserUrl$fbId/");
    var response = await http.patch(
      url,
      body: editInfo,
      headers: header,
    );
    if (response.statusCode == 200) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('presentUser', response.body);
      Utils.showSnackBar("Successfully Updated!...");
      return true;
    } else {
      var data = json.decode(response.body);
      if (data["name"][0] == "user with this username already exists.") {
        Utils.showSnackBar("Username already exits!!!");
        return false;
      }
      Utils.showSnackBar(response.body);
      return false;
    }
  } catch (e) {
    Utils.showSnackBar(e.toString());
  }
  return false;
}
