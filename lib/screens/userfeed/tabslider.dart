// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/screens/userfeed/post.dart';
import 'package:hillfair2022_frontend/screens/userfeed/teamfeed.dart';
import 'package:hillfair2022_frontend/screens/userfeed/userfeed.dart';

import '../../utils/colors.dart';

class TabSlider extends StatefulWidget {
  const TabSlider({super.key});

  @override
  State<TabSlider> createState() => _TabSliderState();
}

class _TabSliderState extends State<TabSlider> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
        length: 2,
        child: Container(
            height: size.height,
            color: bgColor,
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         fit: BoxFit.fill,
            //         image: AssetImage("assets/images/bg.png"))),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Color(0xff44336F),
                bottom: TabBar(
                    indicatorColor: Colors.white,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold),
                    tabs: [
                      Tab(
                        text: "UserFeed",
                      ),
                      Tab(
                        text: "TeamFeed",
                      )
                    ]),
                centerTitle: true,
                title: Text("Feeds",
                    style: TextStyle(
                        fontWeight: FontWeight.bold)),
              ),
              body: TabBarView(children: [UserFeed(), TeamFeed()]),
            )));
  }
}
