import 'package:get/get.dart';

/// Drives the bottom navigation shell across the app.
class NavigationController extends GetxController {
  final currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
