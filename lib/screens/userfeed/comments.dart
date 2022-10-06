// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants/constant.dart';

class Comments extends StatefulWidget {
  const Comments({Key? key}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: appBarColor,
        title: Center(
            widthFactor: 1.3,
            child: Text("Comments",
                style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.bold))),
      ),
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/images/bg.png"))),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white),
                child: Column(
                  children: [
                    ListTile(
                      leading:
                          Image(image: AssetImage("assets/images/member.png")),
                      title: Text("Sanat Thakur",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: appBarColor,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          )),
                      subtitle: Text("Caption goes here",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: appBarColor,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          )),
                    ),
                    Container(
                      height: size.height * .6,
                      // color: Colors.black,
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffD9D9D9)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ExpansionTile(
                                    title: Text("Sanat Thakur",
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: appBarColor,
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                        )),
                                    children: [
                                      Text("Comments ",
                                          textAlign: TextAlign.left,
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: appBarColor,
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
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
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.send,
                                  color: appBarColor,
                                )),
                            hintText: "Enter Comment here",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: appBarColor,
                              fontFamily: GoogleFonts.poppins().fontFamily,
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
                )),
          ),
        ),
      ),
    );
  }
}
