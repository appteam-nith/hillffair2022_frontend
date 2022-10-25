import 'package:cached_network_image/cached_network_image.dart';
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';
import 'package:hillfair2022_frontend/models/userFeed/getComment_model.dart';
import 'package:hillfair2022_frontend/models/userFeed/user_feed_model.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/comment_view_model.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/getComments_viewModels.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../utils/snackbar.dart';

class Comments extends StatefulWidget {
  UserFeedModel post;
  UserModel presentUser;
  Comments(this.post, this.presentUser, {super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  TextEditingController commentTxtController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //post Comments
    _postComment(String postId, String fbId) async {
      String comment = commentTxtController.text;
      var provider = Provider.of<PostCommentViewModel>(context, listen: false);
      await provider.postComment(comment, postId, fbId);
      if (provider.isBack) {
        //has to be completed
        print("comment added");
      }
    }

    Size size = MediaQuery.of(context).size;
    // setState(() {
    //   commentlist = _getCommnnets(widget.postId) as List<dynamic>;
    // });
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Comments", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18), color: Colors.white),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                        backgroundColor: appBarColor,
                        radius: 30,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: CachedNetworkImage(
                            imageUrl: widget.presentUser.profileImage,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: imageProvider,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                              )),
                            ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        )),
                    title: Text(widget.presentUser.name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: appBarColor,
                        )),
                    subtitle: Text(widget.post.text,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: appBarColor,
                        )),
                  ),
                  Container(
                    height: size.height * .6,
                    // color: Colors.black,
                    child: _commentListView(widget.post.id, context),
                  ),
                  Form(
                    key: _formkey,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        controller: commentTxtController,
                        validator: (e) {
                          if (e!.isEmpty) {
                            return "Enter Comment!!!";
                          } else if (e.length > 100) {
                            return "Length should be less than 100 characters!!!";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorHeight: 25,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: appBarColor,
                        ),
                        cursorColor: appBarColor,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    _postComment(widget.post.id,
                                        widget.presentUser.firebase);
                                    setState(() {
                                      commentTxtController.clear();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    });
                                    Utils.showSnackBar("Comment Posted!!!");
                                  }
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: appBarColor,
                                )),
                            hintText: "Enter Comment here",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: appBarColor,
                            ),
                            contentPadding: EdgeInsets.only(left: 20),
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
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  _commentListView(String postId, BuildContext context) {
    //getComments
    Future _getCommnnets(String postId) async {
      var provider = Provider.of<GetCommentsViewModel>(context, listen: false);
      await provider.getComments(postId);
      GetCommentsModel _commentBody = provider.commentbody;
      return _commentBody;
    }

    return FutureBuilder(
        future: _getCommnnets(postId),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: bgColor,
              ),
            );
          } else {
            print(snapshot.data);
            return ListView.builder(
                itemCount: snapshot.data?.postIdScommenters.length,
                itemBuilder: ((context, index) {
                  var comment = snapshot.data!.postIdScommenters[index];
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
                          title: Text(comment.author,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: appBarColor,
                              )),
                          children: [
                            Text(comment.text,
                                textAlign: TextAlign.left,
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: appBarColor,
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
                }));
          }
        }));
  }
}
