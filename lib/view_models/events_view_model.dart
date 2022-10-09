import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/models/error_model.dart';
import '../api_services/api_status.dart';
import '../api_services/event_services.dart';
import '../models/event_model.dart';

class EventsViewModel extends ChangeNotifier {
  EventsViewModel() {
    getEvents();
  }

  bool _loading = false;
  List<EventModel> _eventsListModel = [];
  ErrorModel _eventError = ErrorModel(000, " error not set");

  bool get loading => _loading;
  List<EventModel> get eventsListModel => _eventsListModel;
  ErrorModel get eventError => _eventError;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setEventListModel(List<EventModel> eventsListModel) {
    _eventsListModel = eventsListModel;
  }

  setEventError(ErrorModel eventError) {
    _eventError = eventError;
  }

  getEvents() async {
    setLoading(true);
    var response = await EventServices.getEvents();
    if (response is Success) {
      setEventListModel(response.response as List<EventModel>);
      log(response.response.toString());
    }
    if (response is Failure) {
      ErrorModel eventError = ErrorModel(
        response.code,
        response.errorResponse,
      );
      setEventError(eventError);
    }
    setLoading(false);
  }
}
