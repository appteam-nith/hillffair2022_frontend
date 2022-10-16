// ignore_for_file: prefer_const_constructors

import 'dart:async';

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
import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/userFeed_view_model.dart';
import 'package:provider/provider.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';

import '../../view_models/userFeed_viewModels/getComments_viewModels.dart';

class UserFeed extends StatefulWidget {
  const UserFeed({Key? key}) : super(key: key);

  @override
  State<UserFeed> createState() => _UserFeedState();
}

class _UserFeedState extends State<UserFeed> {
  bool _isliked = false; // to be changed using api
  

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
        });
  }

  @override
  Widget build(BuildContext context) {
    UserFeedViewModel userFeedViewModel = context.watch<UserFeedViewModel>();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: IconButton(
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
          icon: const Icon(
            Icons.add_to_photos_rounded,
            color: appBarColor,
            size: 40,
          )),
      body: _userFeedView(userFeedViewModel, size),
    );
  }

  _userFeedView(UserFeedViewModel userFeedViewModel, Size size) {
    // if (userFeedViewModel.loading) {
    //   return LoadingData();
    // }

    // if (userFeedViewModel.userFeedListModel.isEmpty) {
    //   return Center(
    //     child: Text(
    //       "No Data Present",
    //       style: TextStyle(
    //           color: Colors.white,
    //           fontSize: size.height * .025,
    //           fontFamily: GoogleFonts.poppins().fontFamily,
    //           fontWeight: FontWeight.bold),
    //     ),
    //   );
    // }
    _getFeedList() async {
      var provider = Provider.of<UserFeedViewModel>(context, listen: false);
      await provider.getUserFeed();
      List<UserFeedModel> feedList = provider.userFeedListModel;
      return feedList;
    }

    return FutureBuilder(
      future: _getFeedList(),
      builder: (((context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingData();
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
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * .036,
                            vertical: size.height * .017),
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
                                      borderRadius: BorderRadius.circular(20),
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
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * .02),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        // if (_isliked)
                                        //   _isliked = false;
                                        // else
                                        //   _isliked = true;
                                        // setState(() {});
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
                                        //getComents
                                        // var commentBody =_getCommnnets(userFeedModel.id);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Comments(
                                                    userFeedModel.id, "234")));
                                      },
                                      icon: Icon(Icons.comment_outlined)),
                                  SizedBox(
                                    width: size.width * .03,
                                  ),
                                  Text(
                                      "${userFeedModel.numberOfLikes.toString()} Likes",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: appBarColor,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      )),
                                ],
                              ),

                              // SizedBox(
                              //   width: size.width * .15,
                              // ),
                              TextButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStatePropertyAll(
                                          Colors.transparent)),
                                  onPressed: () {},
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                    ),
                                  )),
                              // TextButton(
                              //     style: ButtonStyle(
                              //         overlayColor:
                              //             MaterialStatePropertyAll(Colors.transparent)),
                              //     onPressed: () {
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) => Post(
                              //                     photourl: userFeedModel.photo,
                              //                     comment: userFeedModel.text,
                              //                   )));
                              //     },
                              //     child: Text(
                              //       "Edit",
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         color: appBarColor,
                              //         fontFamily: GoogleFonts.poppins().fontFamily,
                              //       ),
                              //     ))
                            ]),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * .035,
                            vertical: size.height * .01),
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
      })),
    );
  }
}
