import 'dart:async';

import '../data/dummy_content.dart';
import '../models/safety_alert.dart';

class SafetyService {
  Future<List<SafetyAlert>> fetchAlerts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return DummyContent.safetyAlerts;
  }
}
