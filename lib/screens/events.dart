import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair22_3rdyear/constants/constant.dart';
import 'package:hillfair22_3rdyear/screens/eventDetail.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Events"),
          backgroundColor: appBarColor,
        ),
        body: _eventsListView(),
      ),
    );
  }

  ListView _eventsListView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: ListTile(
            title: Text(
              "Event $index",
              style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Club Name $index \n 02 october 2022"),
            isThreeLine: true,
            leading: const CircleAvatar(
              backgroundColor: appBarColor,
              radius: 45,
              child: Image(image: AssetImage("assets/images/appteam.png")),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailsPage(index),
                ),
              );
            },
          ),
        );
      },
      itemCount: 10,
    );
  }
}
