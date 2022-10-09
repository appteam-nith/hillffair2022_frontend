// ignore_for_file: prefer_const_constructors

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';
import 'package:hillfair2022_frontend/models/user_feed_model.dart';
import 'package:hillfair2022_frontend/screens/userfeed/comments.dart';
import 'package:hillfair2022_frontend/screens/userfeed/post.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_view_model.dart';
import 'package:provider/provider.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';

class UserFeed extends StatefulWidget {
  const UserFeed({Key? key}) : super(key: key);

  @override
  State<UserFeed> createState() => _UserFeedState();
}

class _UserFeedState extends State<UserFeed> {
  bool _isliked = false; // to be changed using api

  @override
  Widget build(BuildContext context) {
    UserFeedViewModel userFeedViewModel = context.watch<UserFeedViewModel>();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              splashRadius: 1,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Post()));
              },
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
        child: _userFeedView(userFeedViewModel, size),
      ),
    );
  }

   _userFeedView(UserFeedViewModel userFeedViewModel, Size size) {
    if (userFeedViewModel.loading) {
      return  LoadingData();
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: userFeedViewModel.userFeedListModel.length,
        itemBuilder: (context, index) {
          UserFeedModel userFeedModel =
              userFeedViewModel.userFeedListModel[index];
          return Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              // height: size.height * .5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18), color: Colors.white),
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
                      title: Text(userFeedModel.author.username,
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
                              image: NetworkImage(userFeedModel.photo))),
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
                    Text(userFeedModel.numberOfLikes.toString(),
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
                      child: Text(userFeedModel.text,
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
        });
  }
}
