import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/screens/teamFeed/teamfeed.dart';
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

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: Color(0xff44336F),
            bottom: TabBar(
                indicatorColor: Colors.white,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    text: "UserFeed",
                  ),
                  Tab(
                    text: "TeamFeed",
                  )
                ]),
            centerTitle: true,
            title: Text("Feeds", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          body: TabBarView(children: [UserFeed(), TeamFeed()]),
        ));
  }
}
