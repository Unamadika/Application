import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/navigation_controller.dart';
import 'guide_profile_screen.dart';
import 'group_joining_screen.dart';
import 'home_screen.dart';
import 'safety_screen.dart';

/// Hosts the four primary tabs and a floating navigation bar.
class RootShell extends StatelessWidget {
  const RootShell({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Get.find<NavigationController>();
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: nav.currentIndex.value,
          children: const [
            HomeScreen(),
            GroupJoiningScreen(),
            SafetyScreen(),
            GuideProfileScreen(),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: NavigationBar(
              selectedIndex: nav.currentIndex.value,
              onDestinationSelected: nav.changeIndex,
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home'),
                NavigationDestination(
                    icon: Icon(Icons.groups_outlined),
                    selectedIcon: Icon(Icons.groups),
                    label: 'Groups'),
                NavigationDestination(
                    icon: Icon(Icons.health_and_safety_outlined),
                    selectedIcon: Icon(Icons.emergency),
                    label: 'Safety'),
                NavigationDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
