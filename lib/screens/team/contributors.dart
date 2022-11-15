// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Contributors extends StatefulWidget {
  Contributors({super.key});

  @override
  State<Contributors> createState() => _TeamMembersState();
}

class _TeamMembersState extends State<Contributors> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var contributors = [
      {
        "name": "Sanat Thakur",
        "profile_image":
            "https://avatars.githubusercontent.com/u/76841209?s=400&u=2521f92edb82f423649fa8403106bffdfb2db5dd&v=4",
        "github": "https://github.com/Sanat2002",
        "insta": "https://www.instagram.com/sanatthakur2002/"
      },
      {
        "name": "Mohd Sohail",
        "profile_image":
            "https://res.cloudinary.com/ddwkvqbbt/image/upload/v1668534477/so_go4qqo.jpg",
        "github": "https://github.com/sohail2000",
        "insta": "https://www.instagram.com/dr.doofenzmirts/"
      },
      {
        "name": "Anmol Choudhary",
        "profile_image":
            "https://res.cloudinary.com/ddwkvqbbt/image/upload/v1668528183/anmol_xk02jt.jpg",
        "github": "https://github.com/Anmol-Choudhary-26",
        "insta": "https://www.instagram.com/_.anmol_choudhary._/"
      },
      {
        "name": "Priyanshu Gupta",
        "profile_image":
            "https://res.cloudinary.com/ddwkvqbbt/image/upload/v1668529055/PRI_txomyg.jpg",
        "github": "https://github.com/priyanshugupta69",
        "insta": "https://www.instagram.com/dking1202/"
      },
      {
        "name": "Suryansh Singh Bisen",
        "profile_image":
            "https://res.cloudinary.com/ddwkvqbbt/image/upload/v1668529055/SURYANSH_eovqte.jpg",
        "github": "https://github.com/07suryansh",
        "insta": "https://www.instagram.com/07suryansh/"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Color(0xffd9d9d9),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text("Developers",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 8, 8, 8))),
      ),
      body: _teamMemberListView(size, contributors),
    );
  }

  _teamMemberListView(Size size, List Contributors) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: Contributors.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.height * .015, horizontal: size.width * .05),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: bgColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundColor: appBarColor,
                    radius: 45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45.0),
                      child: CachedNetworkImage(
                        imageUrl: Contributors[index]["profile_image"],
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
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .15,
                    width: size.width * .56,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Contributors[index]["name"],
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: size.width * .05),
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                var url =
                                    Uri.parse(Contributors[index]["github"]);
                                _launchUrl(url);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: const Color(0xff9E9EEE),
                                splashFactory: NoSplash.splashFactory,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "GitHub",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                            SizedBox(
                              width: size.width * .04,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                var url =
                                    Uri.parse(Contributors[index]["insta"]);
                                _launchUrl(url);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: const Color(0xff9E9EEE),
                                splashFactory: NoSplash.splashFactory,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "Insta",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
