import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';
import 'package:hillfair2022_frontend/models/teamFeed/teamFeed_model.dart';
import 'package:hillfair2022_frontend/screens/teamFeed/teamfeedvideo.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/utils/global.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../api_services/auth_services.dart';
import '../../utils/api_constants.dart';
import '../../view_models/teamFeed_view_model/teamFeedList_view_model.dart';

class TeamFeed extends StatefulWidget {
  const TeamFeed({Key? key}) : super(key: key);

  @override
  State<TeamFeed> createState() => _TeamFeedState();
}

class _TeamFeedState extends State<TeamFeed> {
  bool _isLoadMoreRunning = false;

  Future refresh() {
    var provider = Provider.of<TeamFeedViewModel>(context, listen: false);
    return provider.refesh();
  }

  void _loadMore() async {
    var provider = Provider.of<TeamFeedViewModel>(context, listen: false);
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if (!provider.loading) {
        setState(() {
          _isLoadMoreRunning = true;
        });
        await provider.getTeamFeed();
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
      //           255, 199, 150, 24),
      //       size: 40,
      //     )),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
                color: bgColor,
                child: _teamfeedView(teamFeedViewModel, size),
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

  _teamfeedView(TeamFeedViewModel teamFeedViewModel, Size size) {
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
        controller: _controller,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: teamFeedList.length,
        itemBuilder: (context, index) {
          // UserModel presentUser = teamFeedViewModel.presentUser;
          TeamFeedModel teamFeedModel = teamFeedList[index];
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
                                          volume: 1.0,
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
                              ? TeamFeedVideo(
                                  videourl: teamFeedModel.photo,
                                  volume: 0.0,
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
                              IconButton(
                                  onPressed: () {
                                    _postLike(teamFeedModel.id,
                                        Globals.presentUser.firebase);

                                    if (teamFeedModel.islikedbycurrentuser) {
                                      setState(() {
                                        teamFeedModel.islikedbycurrentuser =
                                            false;
                                        teamFeedModel.numberOfLikes--;
                                      });
                                    } else {
                                      setState(() {
                                        teamFeedModel.islikedbycurrentuser =
                                            true;
                                        teamFeedModel.numberOfLikes++;
                                      });
                                    }
                                  },
                                  icon: teamFeedModel.islikedbycurrentuser
                                      ? Icon(
                                          CupertinoIcons.heart_fill,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          CupertinoIcons.heart,
                                        )),
                              Text(
                                  "${teamFeedModel.numberOfLikes.toString()} Likes",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: appBarColor,
                                  )),
                            ],
                          ),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * .06,
                        vertical: size.height * .02),
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

  void _postLike(id, firebase) async {
    Map<String, String> header = await AuthServices.getAuthHeader();
    var url = Uri.parse("${teamFeedLikeUrl}/$id/$firebase");
    var response = await http.post(url, headers: header);
    print(response);
  }
}
