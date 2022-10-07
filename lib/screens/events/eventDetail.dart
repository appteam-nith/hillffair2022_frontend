import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';

import '../../components/event_detail_card.dart';

class EventDetailsPage extends StatelessWidget {
  final int index;
  const EventDetailsPage(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            title: Text("Event $index"),
            centerTitle: true,
            backgroundColor: appBarColor),
        body: const Center(
          heightFactor: 1.3,
          child: EventDetailCard(),
        ),
      ),
    );
  }
}
