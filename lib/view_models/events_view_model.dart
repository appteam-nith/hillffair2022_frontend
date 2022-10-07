import 'package:flutter/material.dart';
import '../api_services/api_status.dart';
import '../api_services/event_services.dart';
import '../models/event_model.dart';

class EventsViewModel extends ChangeNotifier {
  bool _loading = false;
  List<EventModel> _eventsListModel = [];

  bool get loading => _loading;
  List<EventModel> get eventsListModel => _eventsListModel;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setEventListModel(List<EventModel> eventsListModel) {
    _eventsListModel = eventsListModel;
  }

  getEvents() async {
    setLoading(true);
    var response = await EventServices.getEvents();
    if (response is Success) {
      setEventListModel(response.response as List<EventModel>);
    }
    if (response is Failure) {
      //
    }
    setLoading(true);
  }
}
