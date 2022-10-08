// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:image_picker/image_picker.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  File? selectedImage;
  String imagename = "";

  Future selectImage() async {
    var image;
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        imagename = image.name;
        print(imagename);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage("assets/images/bg.png")),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.white,
            child: Icon(
              Icons.send,
              color: appBarColor,
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: appBarColor,
            title: Text("Post",
                style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.bold)),
          ),
          body: Align(
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
                            selectImage();
                          },
                          child: selectedImage == null
                              ? Icon(
                                  Icons.add_to_photos_rounded,
                                  size: 80,
                                  color: appBarColor,
                                )
                              : Image.file(
                                  selectedImage!,
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
                        cursorColor: appBarColor,
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
