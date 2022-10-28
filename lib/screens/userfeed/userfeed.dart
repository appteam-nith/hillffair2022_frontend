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
import 'package:hillfair2022_frontend/models/user_model.dart';
import 'package:hillfair2022_frontend/screens/userfeed/comments.dart';
import 'package:hillfair2022_frontend/screens/userfeed/post.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/utils/snackbar.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/postLike_viewModel.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/userFeed_view_model.dart';
import 'package:provider/provider.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../utils/api_constants.dart';
import '../../view_models/userFeed_viewModels/getComments_viewModels.dart';

class UserFeed extends StatefulWidget {
  const UserFeed({Key? key}) : super(key: key);

  @override
  State<UserFeed> createState() => _UserFeedState();
}

class _UserFeedState extends State<UserFeed> {
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
                          presentUser: userFeedViewModel.presentUser,
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
    List<UserFeedModel> feedList = userFeedViewModel.prefFeedList;
    List<bool> isLikedList = userFeedViewModel.prefIsLikedList;

    if (!userFeedViewModel.loading) {
      feedList = userFeedViewModel.userFeedListModel;
      isLikedList = userFeedViewModel.isAlreadyLikedList;
    }

    if (feedList.isEmpty) {
      return Center(
        child: LoadingData(),
      );
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: feedList.length,
        itemBuilder: (context, index) {
          UserModel presentUser = userFeedViewModel.presentUser;
          //TODO : filter feedList for userfeed.....
          UserFeedModel userFeedModel = feedList[index];
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
                    padding: EdgeInsets.only(top: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                          backgroundColor: appBarColor,
                          radius: 28,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28.0),
                            child: CachedNetworkImage(
                              imageUrl: userFeedModel.author.profileImage,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: imageProvider,
                                  alignment: Alignment.center,
                                  fit: BoxFit.cover,
                                )),
                              ),
                              placeholder: (context, url) => LoadingData(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          )),
                      title: Text(userFeedModel.author.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: appBarColor,
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * .036,
                        vertical: size.height * .017),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CachedNetworkImage(
                                imageUrl: userFeedModel.photo,
                                imageBuilder: (context, imageProvider) {
                                  return InteractiveViewer(
                                      child: Image(
                                    image: imageProvider,
                                  ));
                                },
                                placeholder: ((context, url) {
                                  return LoadingData();
                                }),
                                errorWidget: ((context, url, error) {
                                  return Icon(
                                    Icons.error,
                                    size: 50,
                                    color: Colors.red,
                                  );
                                }),
                              );
                            });
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
                    padding: EdgeInsets.symmetric(horizontal: size.width * .02),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _postLike(context, userFeedModel.id,
                                        presentUser.firebase);

                                    if (isLikedList[index]) {
                                      setState(() {
                                        isLikedList[index] = false;
                                        userFeedModel.numberOfLikes--;
                                      });
                                    } else {
                                      setState(() {
                                        isLikedList[index] = true;
                                        userFeedModel.numberOfLikes++;
                                      });
                                    }
                                  },
                                  icon: isLikedList[index]
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
                                                userFeedModel, presentUser)));
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
                                  )),
                            ],
                          ),
                          Visibility(
                            visible: userFeedModel.author.firebase ==
                                presentUser.firebase,
                            // userFeedModel.author.fbId == presentUserFbId,
                            child: TextButton(
                                style: ButtonStyle(
                                    overlayColor: MaterialStatePropertyAll(
                                        Colors.transparent)),
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return WillPopScope(
                                            child: LoadingData(),
                                            onWillPop: () async {
                                              return false;
                                            });
                                      });
                                  await deletePost(userFeedModel.id);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                )),
                          ),
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
                          )),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future deletePost(String id) async {
    var url = Uri.parse("$deletePostUrl$id/");
    final http.Response response = await http.delete(url);
    if (response.statusCode == 204) {
      //update feedList
      var provider = Provider.of<UserFeedViewModel>(context, listen: false);
      var filteredList =
          provider.userFeedListModel.where(((element) => element.id != id));
      provider.setUserFeedListModel(filteredList.toList());
      Utils.showSnackBar("Deleted Succesfully!...");
    } else {
      Utils.showSnackBar(response.body);
    }
  }
}

_postLike(BuildContext context, String postId, String fbId) async {
  print("klsfd");
  PostLIkeViewModel provider =
      Provider.of<PostLIkeViewModel>(context, listen: false);
  await provider.postLike(postId, fbId);
  return provider.isLiked;
}
