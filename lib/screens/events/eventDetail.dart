// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/events/event_model.dart';
import '../../view_models/events_view_model.dart';

class EventDetailsPage extends StatelessWidget {
  final int index;
  const EventDetailsPage(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    EventsViewModel eventsViewModel = context.watch<EventsViewModel>();
    return _eventDetailView(eventsViewModel, index);
  }

  Scaffold _eventDetailView(EventsViewModel eventsViewModel, int index) {
    EventModel eventModel = eventsViewModel.eventsListModel[index];
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(eventModel.title),
        centerTitle: true,
      ),
      body: Center(
        heightFactor: 1.3,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: const EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0),
          child: Wrap(
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    CircleAvatar(
                        backgroundColor: appBarColor,
                        radius: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(45.0),
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
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 14, right: 14),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Description :",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      eventModel.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                      style: TextStyle(fontWeight: FontWeight.w500),
                      // softWrap: true,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        _launchUrl(Uri.parse(eventModel.regUrl));
                        // Future.delayed(const Duration(milliseconds: 3000),
                        //     () {
                        //   Navigator.pop(context);
                        // });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff9E9EEE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text("Register"),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: true),
    )) {
      throw 'Could not launch $url';
    }
  }
}
