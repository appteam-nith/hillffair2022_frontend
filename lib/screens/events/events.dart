import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/models/events/event_model.dart';
import 'package:hillfair2022_frontend/screens/events/eventDetail.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:hillfair2022_frontend/view_models/event_view_model/events_view_model.dart';
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListView.builder(
          itemBuilder: (context, index) {
            final DateFormat dayformatter = DateFormat('yMMMMd');
            final DateFormat dateformatter = DateFormat('jm');
            print("event-list");
            print(eventsViewModel.eventsListModel);
            EventModel eventModel = eventsViewModel.eventsListModel[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailsPage(index),
                    ));
              },
              child: Container(
                constraints: BoxConstraints(
                  minHeight: size.height * .14,
                ),
                child: Center(
                  child: Card(
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * .02,
                          vertical: size.width * .03),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.bottomLeft,
                            // color: Colors.yellow,
                            child: CircleAvatar(
                                backgroundColor: appBarColor,
                                radius: 35,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(47),
                                  child: CachedNetworkImage(
                                    imageUrl: eventModel.image,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: imageProvider,
                                        alignment: Alignment.center,
                                        fit: BoxFit.cover,
                                      )),
                                    ),
                                    placeholder: (context, url) =>
                                        LoadingData(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: size.width * .09,
                          ),
                          Container(
                            width: size.width * .52,
                            // color: Colors.black,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  eventModel.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    "${eventModel.clubName}\n${dayformatter.format(eventModel.startTime)}\n${dateformatter.format(eventModel.startTime)}"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: eventsViewModel.eventsListModel.length,
        ),
      ),
    );
  }
}
