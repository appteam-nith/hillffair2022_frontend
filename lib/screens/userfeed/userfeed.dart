// ignore_for_file: prefer_const_constructors

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair22_3rdyear/constants/constant.dart';
import 'package:hillfair22_3rdyear/screens/userfeed/comments.dart';

class UserFeed extends StatefulWidget {
  const UserFeed({Key? key}) : super(key: key);

  @override
  State<UserFeed> createState() => _UserFeedState();
}

class _UserFeedState extends State<UserFeed> {
  bool _isliked = false; // to be changed using api

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              splashRadius: 1,
              onPressed: () {},
              icon: const Icon(Icons.add_to_photos_rounded)),
          PopupMenuButton(
              splashRadius: 1,
              itemBuilder: (context) => [
                    PopupMenuItem(
                        child: TextButton(
                            onPressed: () {},
                            child: Text("Delete",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.bold)))),
                    PopupMenuItem(
                        child: TextButton(
                            onPressed: () {},
                            child: Text("Edit",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.bold))))
                  ])
        ],
        backgroundColor: appBarColor,
        title: Container(
          width: size.width * .58,
          alignment: Alignment.centerRight,
          child: Text("User Feed",
              style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/images/bg.png"))),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  // height: size.height * .5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          leading: Image(
                            image: AssetImage("assets/images/member.png"),
                            height: size.height * .06,
                          ),
                          title: Text("Username",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: appBarColor,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          height: size.height * .3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/images/post.png"))),
                        ),
                      ),
                      Row(children: [
                        IconButton(
                            onPressed: () {
                              if (_isliked)
                                _isliked = false;
                              else
                                _isliked = true;
                              setState(() {});
                            },
                            icon: _isliked
                                ? Icon(
                                    CupertinoIcons.heart_fill,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    CupertinoIcons.heart,
                                  )),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Comments()));
                            },
                            icon: Icon(Icons.comment_outlined)),
                        SizedBox(
                          width: 15,
                        ),
                        Text("20 likes",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: appBarColor,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            )),
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 10),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Caption goes here kflasdf kjla asklf aklfaklsf jaklsjfkla jsflkajfalksdfkas jfkajs flaksj flaksfjalks fjalkf akjfaskjfaslkfjs fjakls fdaks fjlaks fakls jfkalsjflkas jfkals jfkalsjfklasjflkasj",
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: appBarColor,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
