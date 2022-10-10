// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/screens/userfeed/userfeed.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/view_models/post_img_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import '../../models/post_img_model.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final cloudinary = CloudinaryPublic('dugwczlzo', 'nql7r9cr', cache: false);
  File? imageFromDevice;
  TextEditingController captionTxtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future _pickimage(ImageSource source) async {
      try {
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) {
          return;
        }
        File? img = File(image.path);

        setState(() => this.imageFromDevice = img);
        // Navigator.of(context).pop();
      } on PlatformException catch (e) {
        print(e);
        // Navigator.of(context).pop();
      }
    }

    _imgUrl(var image) async {
      try {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path,
              resourceType: CloudinaryResourceType.Image),
        );
        return response.secureUrl;
        // print(response.secureUrl);
      } on CloudinaryException catch (e) {
        print(e.message);
        print(e.request);
        return "";
      }
    }

    _post(var imageFromDevice) async {
      String caption = captionTxtController.text;
      String photoUrl = await _imgUrl(imageFromDevice);
      PostImgModel body =
          PostImgModel(photo: photoUrl, text: caption, location: "location");
      var provider = Provider.of<PostImgViewModel>(context, listen: false);
      await provider.postImg(body, "F5KNLyKjU4d7NCTTxJQCjyS6Qxm1");
      if (provider.isBack) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserFeed()),
        );
      }
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            /*post request */
            _post(imageFromDevice);
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.send,
            color: appBarColor,
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: appBarColor,
          title: Center(
              widthFactor: 1.3,
              child: Text("Post",
                  style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.bold))),
        ),
        body: Container(
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage("assets/images/bg.png")),
          ),
          child: Align(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: size.height * .55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ListTile(
                      leading:
                          Image(image: AssetImage("assets/images/member.png")),
                      title: Text("Sanat Thakur",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        width: size.width * .8,
                        height: size.height * .3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color(0xffD9D9D9)),
                        child: InkWell(
                          onTap: () {
                            _pickimage(ImageSource.gallery);
                          },
                          child: imageFromDevice == null
                              ? Icon(
                                  Icons.add_to_photos_rounded,
                                  size: 80,
                                  color: appBarColor,
                                )
                              : Image.file(
                                  imageFromDevice!,
                                  fit: BoxFit.fill,
                                  filterQuality: FilterQuality.medium,
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        controller: captionTxtController,
                        validator: (e) {
                          if (e!.isEmpty) {
                            return "Enter Comment!!!";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorHeight: 25,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: appBarColor,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                        decoration: InputDecoration(
                            hintText: "Enter Comment here",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: appBarColor,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 20,
                            ),
                            filled: true,
                            fillColor: Color(0xffD9D9D9),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(40)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(40)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(40)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(40))),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
