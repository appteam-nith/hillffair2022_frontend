// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hillfair2022_frontend/screens/chatting/chatting.dart';
import 'package:hillfair2022_frontend/screens/events/events.dart';
import 'package:hillfair2022_frontend/screens/profile/profile.dart';
import 'package:hillfair2022_frontend/screens/team/teamlist.dart';
import 'package:hillfair2022_frontend/screens/userfeed/tabslider.dart';
import 'package:hillfair2022_frontend/screens/userfeed/userfeed.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/screens/chatting/chatting.dart';
import 'package:hillfair2022_frontend/view_models/team_view_model.dart';
import 'package:provider/provider.dart';

import '../../view_models/events_view_model.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List navPages = [TeamList(),TabSlider(), Events(), Profile()];

  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      body: navPages[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(size.width * .03),
          child: GNav(
              activeColor: bgColor,
              color: Color(0xff525252),
              tabBackgroundColor: Color.fromARGB(255, 196, 189, 215),
              gap: 8,
              selectedIndex: currentIndex,
              onTabChange: (int i) {
                setState(() {
                  currentIndex = i;
                });
              },
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              tabs: const [
                GButton(
                  icon: CupertinoIcons.home,
                  text: "Teams",
                ),
                // GButton(
                //   icon: CupertinoIcons.chat_bubble_2,
                //   text: "Chatting",
                // ),
                GButton(
                  icon: Icons.add_a_photo_outlined,
                  text: "UserFeed",
                ),
                GButton(
                  icon: CupertinoIcons.calendar,
                  text: "Events",
                ),
                GButton(
                  icon: CupertinoIcons.person,
                  text: "Profile",
                ),
              ]),
        ),
      ),
    );
  }
}
