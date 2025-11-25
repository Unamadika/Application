import 'package:get/get.dart';

import '../models/event.dart';
import '../models/guide.dart';
import '../models/trip.dart';
import '../services/travel_service.dart';

class HomeController extends GetxController {
  final TravelService _service = TravelService();

  final trips = <Trip>[].obs;
  final events = <CulturalEvent>[].obs;
  final guides = <Guide>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadContent();
  }

  Future<void> loadContent() async {
    isLoading.value = true;
    final results = await Future.wait([
      _service.fetchTrips(),
      _service.fetchEvents(),
      _service.fetchGuides(),
    ]);
    trips.assignAll(results[0] as List<Trip>);
    events.assignAll(results[1] as List<CulturalEvent>);
    guides.assignAll(results[2] as List<Guide>);
    isLoading.value = false;
  }
}
