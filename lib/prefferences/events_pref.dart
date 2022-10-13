import 'dart:convert';

import 'package:hillfair2022_frontend/models/event_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesevents{
  static SharedPreferences? _preferences;
  static const eventsKey="events";
  static init()async{
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }
  static saveEvent(String n) async {
    List<String> eventsList = await getEventsList();
    eventsList.add(n);
    print(eventsList);
    return _preferences!.setStringList(eventsKey, eventsList);

  }
  static Future<List<String>> getEventsList() async {
    return _preferences!.getStringList(eventsKey) ?? [];
  }

  static Future<List<EventModel>> getEvents() async {
    List<String> eventsList = await getEventsList();
    List<EventModel> eventModelList = [];
    for (String eventString in eventsList) {
      eventModelList.add(EventModel.fromJson(jsonDecode(eventString)));
    }

    print(eventModelList);

    return eventModelList;
  }
}