import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/group.dart';
import '../services/travel_service.dart';

class GroupController extends GetxController {
  final TravelService _service = TravelService();

  final groups = <TravelGroup>[].obs;
  final isLoading = true.obs;
  final selectedRegions = <String>[].obs;
  final priceRange = const RangeValues(200, 500).obs;

  @override
  void onInit() {
    super.onInit();
    loadGroups();
  }

  Future<void> loadGroups() async {
    isLoading.value = true;
    final data = await _service.fetchGroups();
    groups.assignAll(data);
    isLoading.value = false;
  }

  void toggleRegion(String region) {
    if (selectedRegions.contains(region)) {
      selectedRegions.remove(region);
    } else {
      selectedRegions.add(region);
    }
  }

  void updatePrice(RangeValues values) {
    priceRange.value = values;
  }

  List<TravelGroup> get filteredGroups {
    return groups.where((group) {
      final matchesDest = selectedRegions.isEmpty ||
          selectedRegions.any((dest) =>
              group.region.toLowerCase().contains(dest.toLowerCase()));
      final withinPrice = group.price >= priceRange.value.start &&
          group.price <= priceRange.value.end;
      return matchesDest && withinPrice;
    }).toList();
  }

  List<String> get destinationTags =>
      groups.map((g) => g.region.split(',').first).toSet().toList();
}
