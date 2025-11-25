import 'dart:async';

import '../data/dummy_content.dart';
import '../models/event.dart';
import '../models/guide.dart';
import '../models/group.dart';
import '../models/trip.dart';

/// Simulated network service returning travel-related content.
class TravelService {
  Future<List<Trip>> fetchTrips() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return DummyContent.trips;
  }

  Future<List<CulturalEvent>> fetchEvents() async {
    await Future.delayed(const Duration(milliseconds: 550));
    return DummyContent.events;
  }

  Future<List<Guide>> fetchGuides() async {
    await Future.delayed(const Duration(milliseconds: 520));
    return DummyContent.guides;
  }

  Future<List<TravelGroup>> fetchGroups() async {
    await Future.delayed(const Duration(milliseconds: 580));
    return DummyContent.groups;
  }
}
