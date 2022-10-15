// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/screens/userfeed/userfeed.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/post_img_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import '../../models/userFeed/post_img_model.dart';

class Post extends StatefulWidget {
  var photourl;
  var comment;
  Post({super.key, required this.photourl, required this.comment});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final cloudinary = CloudinaryPublic('dugwczlzo', 'nql7r9cr', cache: false);
  File? imageFromDevice;
  late TextEditingController captionTxtController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    captionTxtController = TextEditingController(text: widget.comment);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future _pickimage(ImageSource source) async {
      widget.photourl = null;
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
      PostImgModel body = PostImgModel(photo: photoUrl, text: caption);
      
      var provider = Provider.of<PostImgViewModel>(context, listen: false);
      await provider.postImg(body, "234");
      if (provider.isBack) {
        Navigator.pop(context);
      }
    }

    return Container(
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage("assets/images/bg.png")),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
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
              centerTitle: true,
              title: Text("Post",
                  style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.bold)),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .1,
                  ),
                  Align(
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
                              leading: Image(
                                  image:
                                      AssetImage("assets/images/member.png")),
                              title: Text("Sanat Thakur",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
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
                                  child: widget.photourl == null
                                      ? imageFromDevice == null
                                          ? Icon(
                                              Icons.add_to_photos_rounded,
                                              size: 80,
                                              color: appBarColor,
                                            )
                                          : Image.file(
                                              imageFromDevice!,
                                              fit: BoxFit.fill,
                                              filterQuality:
                                                  FilterQuality.medium,
                                            )
                                      : Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(widget.photourl)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: TextFormField(
                                cursorColor: appBarColor,
                                controller: captionTxtController,
                                validator: (e) {
                                  if (e!.isEmpty) {
                                    return "Enter Comment!!!";
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                    ),
                                    contentPadding: EdgeInsets.only(
                                      left: 20,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xffD9D9D9),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(40))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
