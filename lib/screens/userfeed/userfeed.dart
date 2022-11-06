// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';
import 'package:hillfair2022_frontend/models/userFeed/user_feed_model.dart';
import 'package:hillfair2022_frontend/models/user_profile/user_model.dart';
import 'package:hillfair2022_frontend/screens/userfeed/comments.dart';
import 'package:hillfair2022_frontend/screens/userfeed/post.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/postLike_viewModel.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/userFeed_view_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../utils/api_constants.dart';

class UserFeed extends StatefulWidget {
  const UserFeed({Key? key}) : super(key: key);

  @override
  State<UserFeed> createState() => _UserFeedState();
}

class _UserFeedState extends State<UserFeed> {
  Future refresh() {
    var provider = Provider.of<UserFeedViewModel>(context, listen: false);
    return provider.getUserFeed();
  }

  // To make in use
  // final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // int _page = 0;

  // final int _limit = 20;

  // bool _isFirstLoadRunning = false;
  // bool _hasNextPage = true;

  bool _isLoadMoreRunning = false;

  // List _posts = [];

  void _loadMore() async {
    // if (_hasNextPage == true &&
    //     _isFirstLoadRunning == false &&
    //     _isLoadMoreRunning == false &&
    //     _controller.position.extentAfter < 300) {
    //   setState(() {
    //     _isLoadMoreRunning = true; // Display a progress indicator at the bottom
    //   });

    //   _page += 1; // Increase _page by 1

    //   try {
    //     final res =
    //         await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));

    //     final List fetchedPosts = json.decode(res.body);
    //     if (fetchedPosts.isNotEmpty) {
    //       setState(() {
    //         _posts.addAll(fetchedPosts);
    //       });
    //     } else {
    //       setState(() {
    //         _hasNextPage = false;
    //       });
    //     }
    //   } catch (err) {
    //     if (kDebugMode) {
    //       print('Something went wrong!');
    //     }
    //   }

    //   setState(() {
    //     _isLoadMoreRunning = false;
    //   });
    // }

    setState(() {
      _isLoadMoreRunning = true;
    });

    var provider = await Provider.of<UserFeedViewModel>(context, listen: false);
    await provider.getUserFeed();

    setState(() {
      _isLoadMoreRunning = false;
    });
  }

  // void _firstLoad() async {
  //   setState(() {
  //     _isFirstLoadRunning = true;
  //   });

  //   try {
  //     final res =
  //         await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
  //     setState(() {
  //       _posts = json.decode(res.body);
  //     });
  //   } catch (err) {
  //     if (kDebugMode) {
  //       print('Something went wrong');
  //     }
  //   }

  //   setState(() {
  //     _isFirstLoadRunning = false;
  //   });
  // }

  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    // var provider = Provider.of<UserFeedViewModel>(context, listen: false);
    // _posts.addAll(provider.userFeedListModel);
    // _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  Widget build(BuildContext context) {
    UserFeedViewModel userFeedViewModel = context.watch<UserFeedViewModel>();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Container(
        height: size.width * .15,
        width: size.width * .15,
        decoration: BoxDecoration(
            color: Color(0xff7C70D4), borderRadius: BorderRadius.circular(40)),
        child: IconButton(
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
              color: Colors.white, // TODO : TO GIVE THE RIGHT COLOR
              size: 35,
            )),
        // InkWell(
        //   child: Icon(
        //     Icons.add_to_photos_rounded,
        //     color: Colors.white,
        //     size: 35,
        //   ),
        // ),
      ),
      // floatingActionButton: IconButton(
      //     splashRadius: 1,
      //     onPressed: () {
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) => Post(
      //                     presentUser: userFeedViewModel.presentUser,
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
      // body: _userFeedView(userFeedViewModel, size),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
                color: bgColor,
                child: _userFeedView(userFeedViewModel, size),
                onRefresh: refresh),
          ),
          if (_isLoadMoreRunning == true)
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 40),
              child: Center(
                child: LoadingData(),
              ),
            ),
          // if (_hasNextPage == false)
          //   Container(
          //     padding: const EdgeInsets.only(top: 30, bottom: 40),
          //     color: Colors.amber,
          //     child: const Center(
          //       child: Text('You have fetched all of the content'),
          //     ),
          //   ),
        ],
      ),
    );
  }

  _userFeedView(UserFeedViewModel userFeedViewModel, Size size) {
    List<UserFeedModel> feedList = userFeedViewModel.prefFeedList;
    List<bool> isLikedList = userFeedViewModel.prefIsLikedList;

    print("main");
    print(feedList.length);
    print(isLikedList.length);

    if (!userFeedViewModel.loading) {
      feedList = userFeedViewModel.userFeedListModel;
      isLikedList = userFeedViewModel.isAlreadyLikedList;
    }

    if (feedList.isEmpty) {
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
                            barrierColor: Colors.black,
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
                                  onPressed: () async {
                                    await _postLike(context, userFeedModel.id,
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
      // Utils.showSnackBar("Deleted Succesfully!...");
    } else {
      // Utils.showSnackBar(response.body);
    }
  }
}

_postLike(BuildContext context, String postId, String fbId) async {
  print("klsfd");
  PostLIkeViewModel provider =
      Provider.of<PostLIkeViewModel>(context, listen: false);
  await provider.postLike(postId, fbId);
  print("liked");
  return provider.isLiked;
}
