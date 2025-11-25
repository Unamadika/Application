import 'package:get/get.dart';

import '../models/safety_alert.dart';
import '../services/safety_service.dart';

class SafetyController extends GetxController {
  final SafetyService _service = SafetyService();

  final alerts = <SafetyAlert>[].obs;
  final isLoading = true.obs;
  final isSosActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAlerts();
  }

  Future<void> loadAlerts() async {
    isLoading.value = true;
    final data = await _service.fetchAlerts();
    alerts.assignAll(data);
    isLoading.value = false;
  }

  void toggleSos() {
    isSosActive.toggle();
  }
}
