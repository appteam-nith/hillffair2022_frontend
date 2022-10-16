import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';
import 'package:hillfair2022_frontend/models/userFeed/getComment_model.dart';
import 'package:hillfair2022_frontend/utils.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/comment_view_model.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/getComments_viewModels.dart';
import 'package:provider/provider.dart';

class Comments extends StatefulWidget {
  String postId;
  String fbId;
  Comments(this.postId, this.fbId, {super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  TextEditingController commentTxtController = TextEditingController();

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
    return Container(
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage("assets/images/bg.png"))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: appBarColor,
            title: Text("Comments",
                style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.bold)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Image(
                            image: AssetImage("assets/images/member.png")),
                        title: Text(widget.fbId,
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
                        child: _commentListView(widget.postId, context),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextFormField(
                          controller: commentTxtController,
                          // validator: (e) {
                          //   if (e!.isEmpty) {
                          //     return "Enter Comment!!!";
                          //   }
                          //   return null;
                          // },
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
                                  onPressed: () {
                                    _postComment(widget.postId, widget.fbId);
                                    setState(() {
                                      commentTxtController.clear();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    });
                                    Utils.showSnackBar("Comment Posted!!!");
                                  },
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
                      )
                    ],
                  )),
            ),
          ),
        ));
  }

  _commentListView(String postId, BuildContext context) {
    //getComments
    
    _getCommnnets(String postId) async {
      var provider = Provider.of<GetCommentsViewModel>(context, listen: false);
      await provider.getComments(postId);
      GetCommentsModel _commentBody = provider.commentbody;
      return _commentBody;
    }

    return FutureBuilder(
        future: _getCommnnets(postId),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingData();
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
                          title: Text(comment.text,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: appBarColor,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              )),
                          children: [
                            Text(comment.author,
                                textAlign: TextAlign.left,
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: appBarColor,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
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
