import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/models/event_model.dart';
import 'package:hillfair2022_frontend/screens/events/eventDetail.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/view_models/events_view_model.dart';
import 'package:provider/provider.dart';

import '../../components/loading_data.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    EventsViewModel eventsViewModel = context.
    watch<EventsViewModel>();
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
        body: _eventsListView(eventsViewModel),
      ),
    );
  }

  _eventsListView(EventsViewModel eventsViewModel) {
    if (eventsViewModel.loading) {
      return const LoadingData();
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        EventModel eventModel = eventsViewModel.eventsListModel[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: ListTile(
            title: Text( 
              eventModel.title,
              style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text("${eventModel.clubName}\n${eventModel.startTime}"),
            isThreeLine: true,
            leading: CircleAvatar(
              backgroundColor: appBarColor,
              radius: 45,
              child: CachedNetworkImage(
                imageUrl: eventModel.image,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
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
      itemCount: eventsViewModel.eventsListModel.length,
    );
  }
}
