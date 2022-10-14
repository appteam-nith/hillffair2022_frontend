// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';
import 'package:hillfair2022_frontend/models/userFeed/user_feed_model.dart';
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

    return Container(
      height: size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage("assets/images/bg.png"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            IconButton(
                splashRadius: 1,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Post(
                                photourl: null,
                                comment: null,
                              )));
                },
                icon: const Icon(Icons.add_to_photos_rounded)),
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
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/bg.png"))),
          child: _userFeedView(userFeedViewModel, size),
        ),
      ),
    );
  }

  _userFeedView(UserFeedViewModel userFeedViewModel, Size size) {
    if (userFeedViewModel.loading) {
      return LoadingData();
    }

    showphoto(BuildContext context, photo) async {
      Size size = MediaQuery.of(context).size;
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SizedBox(
                height: size.height * .3,
                child: CachedNetworkImage(
                  imageUrl: photo,
                  imageBuilder: ((context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                    );
                  }),
                  placeholder: ((context, url) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: appBarColor,
                      ),
                    );
                  }),
                  errorWidget: (context, url, error) {
                    return Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 40,
                    );
                  },
                ),
              ),
            );
            return AlertDialog(
              content: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(photo))),
                width: size.width,
                height: size.height * .3,
              ),
            );
          });
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
                    child: InkWell(
                      onTap: () {
                        showphoto(context, userFeedModel.photo);
                      },
                      child: SizedBox(
                        height: size.height * .3,
                        child: CachedNetworkImage(
                          imageUrl: userFeedModel.photo,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider,
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover)),
                            );
                          },
                          placeholder: ((context, url) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: appBarColor,
                              ),
                            );
                          }),
                          errorWidget: ((context, url, error) {
                            return Icon(
                              Icons.error,
                              size: 50,
                              color: Colors.red,
                            );
                          }),
                        ),
                      ),
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
                                  builder: (context) => Comments(
                                      userFeedModel.id,
                                      "F5KNLyKjU4d7NCTTxJQCjyS6Qxm1")));
                        },
                        icon: Icon(Icons.comment_outlined)),
                    SizedBox(
                      width: 15,
                    ),
                    Text("${userFeedModel.numberOfLikes.toString()} Likes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: appBarColor,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        )),
                    SizedBox(
                      width: size.width * .15,
                    ),
                    TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStatePropertyAll(Colors.transparent)),
                        onPressed: () {},
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        )),
                    TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStatePropertyAll(Colors.transparent)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Post(
                                        photourl: userFeedModel.photo,
                                        comment: userFeedModel.text,
                                      )));
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: appBarColor,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ))
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
