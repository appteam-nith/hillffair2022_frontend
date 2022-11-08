// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';
import 'package:hillfair2022_frontend/models/teamFeed/teamFeed_model.dart';
import 'package:hillfair2022_frontend/models/userFeed/user_feed_model.dart';
import 'package:hillfair2022_frontend/models/user_profile/user_model.dart';
import 'package:hillfair2022_frontend/screens/teamFeed/teamfeedvideo.dart';
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
// import 'package:video_player/video_player.dart';
import '../../utils/api_constants.dart';
import '../../view_models/teamFeed_VMs/teamFeedList_VM.dart';
import '../../view_models/userFeed_viewModels/getComments_viewModels.dart';
// import 'package:vimeo_video_player/vimeo_video_player.dart';
// import 'package:videos_player/videos_player.dart';

class TeamFeed extends StatefulWidget {
  const TeamFeed({Key? key}) : super(key: key);

  @override
  State<TeamFeed> createState() => _TeamFeedState();
}

class _TeamFeedState extends State<TeamFeed> {
  bool _isLoadMoreRunning = false;

  Future refresh() {
    var provider = Provider.of<TeamFeedViewModel>(context, listen: false);
    return provider.getTeamFeed();
  }

  void _loadMore() async {
    var provider = Provider.of<UserFeedViewModel>(context, listen: false);
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if (!provider.loading) {
        setState(() {
          _isLoadMoreRunning = true;
        });
        await provider.getUserFeed();
        setState(() {
          _isLoadMoreRunning = false;
        });
      }
    }
  }

  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_loadMore);
  }


  @override
  Widget build(BuildContext context) {
    TeamFeedViewModel teamFeedViewModel = context.watch<TeamFeedViewModel>();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      // floatingActionButton: IconButton(
      //     splashRadius: 1,
      //     onPressed: () {
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) => Post(
      //                     presentUser: teamFeedViewModel.presentUser,
      //                     photourl: null,
      //                     comment: null,
      //                   )));
      //     },
      //     icon: const Icon(
      //       Icons.add_to_photos_rounded,
      //       color: Color.fromARGB(
      //           255, 199, 150, 24), // TODO : TO GIVE THE RIGHT COLOR
      //       size: 40,
      //     )),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
                color: bgColor,
                child: _userFeedView(teamFeedViewModel, size),
                onRefresh: refresh),
          ),
          if (_isLoadMoreRunning == true)
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 40),
              child: Center(
                child: LoadingData(),
              ),
            ),
        ],
      ),
    );
  }

  _userFeedView(TeamFeedViewModel teamFeedViewModel, Size size) {
    List<TeamFeedModel> teamFeedList = teamFeedViewModel.prefTeamFeedList;
    // List<bool> isLikedList = teamFeedViewModel.prefIsLikedList;

    if (!teamFeedViewModel.loading) {
      teamFeedList = teamFeedViewModel.teamFeedListModel;
      // isLikedList = teamFeedViewModel.isTeamFeedAlreadyLikedList;
    }

    if (teamFeedList.isEmpty) {
      return Center(
        child: Text(
          "No Data Present",
          style: TextStyle(
              color: Colors.white,
              fontSize: size.height * .025,
              fontWeight: FontWeight.bold),
        ),
      );
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          UserModel presentUser = teamFeedViewModel.presentUser;
          TeamFeedModel teamFeedModel = teamFeedList[index];
          print(teamFeedModel.photo);
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
                              imageUrl: teamFeedModel.author.profileImage,
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
                      title: Text(teamFeedModel.author.name,
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
                        teamFeedModel.isVid
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => TeamFeedVideo(
                                          videourl: teamFeedModel.photo,
                                        ))))
                            : showDialog(
                            barrierColor: Colors.black,
                            context: context,
                            builder: (context) {
                              return CachedNetworkImage(
                                imageUrl: teamFeedModel.photo,
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
                          child: teamFeedModel.isVid
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/post.png"),
                                          alignment: Alignment.center,
                                          fit: BoxFit.cover)),
                                )
                              : CachedNetworkImage(
                                  imageUrl: teamFeedModel.photo,
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .02),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // IconButton(
                              //     onPressed: () {
                              //       _postLike(context, teamFeedModel.id,
                              //           presentUser.firebase);

                              //       if (isLikedList[index]) {
                              //         setState(() {
                              //           isLikedList[index] = false;
                              //           teamFeedModel.numberOfLikes--;
                              //         });
                              //       } else {
                              //         setState(() {
                              //           isLikedList[index] = true;
                              //           teamFeedModel.numberOfLikes++;
                              //         });
                              //       }
                              //     },
                              //     icon: isLikedList[index]
                              //         ? Icon(
                              //             CupertinoIcons.heart_fill,
                              //             color: Colors.red,
                              //           )
                              //         : Icon(
                              //             CupertinoIcons.heart,
                              //           )),
                              // IconButton(
                              //     onPressed: () {
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) => Comments(
                              //                   teamFeedModel, presentUser)));
                              //     },
                              //     icon: Icon(Icons.comment_outlined)),
                              SizedBox(
                                width: size.width * .03,
                              ),
                              // Text(
                              //     "${teamFeedModel.numberOfLikes.toString()} Likes",
                              //     style: TextStyle(
                              //       fontWeight: FontWeight.bold,
                              //       color: appBarColor,
                              //     )),
                            ],
                          ),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * .06,
                        vertical: size.height * .01),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(teamFeedModel.text,
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

  // Future deletePost(String id) async {
  //   var url = Uri.parse("$deletePostUrl$id/");
  //   final http.Response response = await http.delete(url);
  //   if (response.statusCode == 204) {
  //     //update teamFeedList
  //     var provider = Provider.of<TeamFeedViewModel>(context, listen: false);
  //     var filteredList =
  //         provider.userFeedListModel.where(((element) => element.id != id));
  //     provider.setUserFeedListModel(filteredList.toList());
  //     Utils.showSnackBar("Deleted Succesfully!...");
  //   } else {
  //     Utils.showSnackBar(response.body);
  //   }
  // }
}

//TODO  : TEAMfEED LIKE SERVICES......
_postLike(BuildContext context, String postId, String fbId) async {
  // print("klsfd");
  PostLIkeViewModel provider =
      Provider.of<PostLIkeViewModel>(context, listen: false);
  await provider.postLike(postId, fbId);
  return provider.isLiked;
}
