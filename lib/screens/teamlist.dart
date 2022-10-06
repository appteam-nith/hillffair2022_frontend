// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair22_3rdyear/constants/constant.dart';
import 'package:hillfair22_3rdyear/screens/teammembers.dart';

class TeamList extends StatefulWidget {
  TeamList({Key? key}) : super(key: key);

  @override
  State<TeamList> createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Center(
            child: Text("Team List",
                style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.bold))),
      ),
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
            border: Border(),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/images/bg.png"))),
        child: GridView.builder(
            itemCount: 12,
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 12),
                child: InkWell(
                  onTap: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TeamMembers()));
                  }),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundColor: appBarColor,
                          radius: 45,
                          child: Image(
                            image: AssetImage("assets/images/appteam.png"),
                            height: size.height * .1,
                          ),
                        ),
                        Text(
                          "App Team",
                          style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
