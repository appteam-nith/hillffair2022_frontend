import 'package:flutter/material.dart';
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



class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Color backgroundColor = Colors.white;
  int selectedindex = 0;

  List<NavigationItem> items = [
    NavigationItem(Icon(Icons.home), Text("Home")),
    NavigationItem(Icon(Icons.groups), Text("Teams")),
    NavigationItem(Icon(Icons.chat), Text("Chat")),
    NavigationItem(Icon(Icons.calendar_month), Text("List")),
    NavigationItem(Icon(Icons.person), Text("Profile")),
  ];

  Widget _buildItem(NavigationItem item, bool isselected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 220 ),
      height: double.maxFinite,
      width: isselected ? 100 : 50,
      padding: isselected ? EdgeInsets.only(left: 8, right: 8) : null,
      decoration: isselected
          ? BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(50)))
          : null,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget> [

              IconTheme(
                  data: IconThemeData(
                      size: 24,
                      color: isselected ? backgroundColor : Colors.black12),
                  child: item.icon),
              Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: isselected
                      ? DefaultTextStyle.merge(
                      style: TextStyle(
                        color: backgroundColor,
                      ),
                      child: item.title)
                      : Container()),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.only(left: 6, top: 4, bottom: 4, right: 6),
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var itemIndex = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedindex = itemIndex;
              });
            },
            child: _buildItem(item, selectedindex == itemIndex),
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  late final Icon icon;
  late final Text title;

  NavigationItem(this.icon, this.title) {}
}