// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';
import 'package:hillfair2022_frontend/models/user_profile/user_model.dart';
import 'package:hillfair2022_frontend/screens/userfeed/userfeed.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/utils/snackbar.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/post_img_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import '../../models/userFeed/post_img_model.dart';
import '../../models/userFeed/user_feed_model.dart';
import '../../view_models/userFeed_viewModels/userFeed_view_model.dart';

class Post extends StatefulWidget {
  var photourl;
  var comment;
  UserModel presentUser;
  Post(
      {super.key,
      required this.photourl,
      required this.comment,
      required this.presentUser});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final cloudinary = CloudinaryPublic('dugwczlzo', 'nql7r9cr', cache: false);
  File? imageFromDevice;
  String res = "";
  bool isselectedImage = true;
  late TextEditingController captionTxtController;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    captionTxtController = TextEditingController(text: widget.comment);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future _pickimage(ImageSource source) async {
      widget.photourl = null;
      imageFromDevice = null;
      try {
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) {
          isselectedImage = false;
          return;
        }
        File? img = File(image.path);

        print(img.lengthSync() ~/ 1024);

        if (img.lengthSync() ~/ 1024 <= 15000) {
          setState(() {
            imageFromDevice = img;
          });
        }
        else{
        isselectedImage = true;
      }
      } on PlatformException catch (e) {
        print(e);
      }
    }

    _imgUrl(var image) async {
      try {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path,
              resourceType: CloudinaryResourceType.Image),
        );
        return response.secureUrl;
      } on CloudinaryException catch (e) {
        print(e.message);
        print(e.request);
        return "";
      }
    }

    Future<File> compressImage({
      required File imagepath,
    }) async {
      var path = await FlutterNativeImage.compressImage(imagepath.absolute.path,
          quality: 100, percentage: 35);
      return path;
    }

    _post(var imageFromDevice) async {
      String caption = captionTxtController.text;

      if (imageFromDevice == null) {
        return "Select Image";
      }

      print(imageFromDevice.lengthSync() / 1024);
      File compressedFile = await compressImage(imagepath: imageFromDevice);
      print(compressedFile.lengthSync() / 1024);
      String photoUrl = await _imgUrl(compressedFile);
      PostImgModel body = PostImgModel(photo: photoUrl, text: caption);

      var provider = Provider.of<PostImgViewModel>(context, listen: false);
      if (widget.presentUser.firebase != "firebase") {
        var addedFeedList =
            await provider.postImg(body, widget.presentUser.firebase);

        return addedFeedList;
      }
    }

    return Scaffold(
        backgroundColor: bgColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_formkey.currentState!.validate()) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return WillPopScope(
                        onWillPop: () async {
                          if (res == "Updated") {
                            return true;
                          }
                          return false;
                        },
                        child: LoadingData());
                  });
              var addedList = await _post(imageFromDevice);
              if (addedList == "Select Image") {
                Navigator.pop(context);
                return;
              }
              res = await upadateFeedList(addedList);
              Navigator.pop(context);
              Navigator.pop(context);

              // if (res == "Updated") {
              //   Utils.showSnackBar("Successfully Posted!!!");
              // }

            }
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.send,
            color: appBarColor,
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text("Post", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .1,
              ),
              Align(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: size.height * .55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                              backgroundColor: appBarColor,
                              radius: 30,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: CachedNetworkImage(
                                  imageUrl: widget.presentUser.profileImage,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
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
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            width: size.width * .8,
                            height: size.height * .3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Color(0xffD9D9D9)),
                            child: InkWell(
                              onTap: () async {
                                await _pickimage(ImageSource.gallery);
                                print(imageFromDevice);
                                if (imageFromDevice == null && isselectedImage == true) {
                                  Utils.showSnackBar(
                                      "Image size should less than 15 MB!!!");
                                }
                              },
                              child: widget.photourl == null
                                  ? imageFromDevice == null
                                      ? Icon(
                                          Icons.add,
                                          size: 80,
                                          color: appBarColor,
                                        )
                                      : Image.file(
                                          imageFromDevice!,
                                          fit: BoxFit.fill,
                                          filterQuality: FilterQuality.medium,
                                        )
                                  : Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(widget.photourl)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Form(
                            key: _formkey,
                            child: TextFormField(
                              cursorColor: appBarColor,
                              controller: captionTxtController,
                              validator: (e) {
                                if (e!.isEmpty) {
                                  return "Enter Caption!!!";
                                } else if (e.length > 100) {
                                  return "Length should be less than 100 characters!!!";
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              cursorHeight: 25,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: appBarColor,
                              ),
                              decoration: InputDecoration(
                                  hintText: "Enter Caption here",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: appBarColor,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 20,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xffD9D9D9),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(40)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(40)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(40)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(40))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  //update_FeedList

  upadateFeedList(UserFeedModel addedFeed) async {
    var provider = Provider.of<UserFeedViewModel>(context, listen: false);
    // await provider.getUserFeed();
    provider.userFeedListModel.insert(0, addedFeed);

    provider.setUserFeedListModel(provider.userFeedListModel);
    provider.isAlreadyLikedList.insert(0, false);
    return "Updated";
  }
}
