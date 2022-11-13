// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/models/events/event_model.dart';
import 'package:hillfair2022_frontend/screens/events/eventDetail.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/view_models/events_view_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../components/loading_data.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  Future refresh() {
    var provider = Provider.of<EventsViewModel>(context, listen: false);
    return provider.getEvents();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    EventsViewModel eventsViewModel = context.watch<EventsViewModel>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Events"),
      ),
      body: RefreshIndicator(
          color: bgColor,
          child: _eventsListView(eventsViewModel, size),
          onRefresh: refresh),
    );
  }

  _eventsListView(EventsViewModel eventsViewModel, Size size) {
    print(eventsViewModel.eventError.code);
    print(eventsViewModel.eventError.errorMessage);
    print(eventsViewModel.eventsListModel.isEmpty);
    print(eventsViewModel.eventsListModel.length);

    if (eventsViewModel.loading) {
      return const LoadingData();
    }

    // if (eventsViewModel.eventsListModel.isEmpty) {
    //   return Center(
    //     child: Text(
    //       "No Data Present",
    //       style: TextStyle(
    //           color: Colors.white,
    //           fontSize: size.height * .025,
    //           fontWeight: FontWeight.bold),
    //     ),
    //   );
    // }

    return ListView.builder(
      itemBuilder: (context, index) {
        final DateFormat dayformatter = DateFormat('yMMMMd');
        final DateFormat dateformatter = DateFormat('jm');
        print("event-list");
        print(eventsViewModel.eventsListModel);
        EventModel eventModel = eventsViewModel.eventsListModel[index];
        return Container(
          constraints: BoxConstraints(
            minHeight: size.height * .14,
          ),
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: ListTile(
                title: Text(
                  eventModel.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    "${eventModel.clubName}\n${dayformatter.format(eventModel.startTime)}\n${dateformatter.format(eventModel.startTime)}"),
                isThreeLine: true,
                leading: CircleAvatar(
                    backgroundColor: appBarColor,
                    radius: 47,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: eventModel.image,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: imageProvider,
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                          )),
                        ),
                        placeholder: (context, url) => LoadingData(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailsPage(index),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      itemCount: eventsViewModel.eventsListModel.length,
    );
  }
}
