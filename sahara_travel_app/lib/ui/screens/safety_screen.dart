import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/safety_controller.dart';
import '../../models/safety_alert.dart';
import '../../ui/widgets/responsive_builder.dart';
import '../../ui/widgets/section_header.dart';

/// Safety tab with SOS action, map placeholder, and alerts.
class SafetyScreen extends GetView<SafetyController> {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: _SafetyLayout(
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20)),
      tablet: _SafetyLayout(
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 32)),
    );
  }
}

class _SafetyLayout extends StatelessWidget {
  const _SafetyLayout({required this.controller, required this.padding});

  final SafetyController controller;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safety hub')),
      body: Obx(() {
        return ListView(
          padding: padding,
          children: [
            const SectionHeader(title: 'Emergency SOS', subtitle: 'Share real-time GPS with the Sahara support team'),
            const SizedBox(height: 16),
            _SosButton(
                isActive: controller.isSosActive.value,
                onTap: controller.toggleSos),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Live tracking'),
            const SizedBox(height: 12),
            _MapPlaceholder(),
            const SizedBox(height: 28),
            const SectionHeader(title: 'Weather & route alerts', subtitle: 'Updated every 15 minutes'),
            const SizedBox(height: 12),
            if (controller.isLoading.value)
              const Center(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator()))
            else
              ...controller.alerts.map((alert) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _AlertCard(alert: alert),
                  )),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Emergency contacts'),
            const SizedBox(height: 12),
            _ContactCard(
              icon: Icons.call,
              label: 'Local rescue line',
              description: '+216 77 123 456',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _ContactCard(
              icon: Icons.forum_outlined,
              label: 'Sahara safety desk',
              description: 'support@saharatravel.app',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _ContactCard(
              icon: Icons.health_and_safety_outlined,
              label: 'Medical assistance',
              description: 'Douz clinic • +216 77 654 321',
              onTap: () {},
            ),
          ],
        );
      }),
    );
  }
}

class _SosButton extends StatelessWidget {
  const _SosButton({required this.isActive, required this.onTap});

  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: isActive
                      ? [Colors.red.shade400, Colors.red.shade700]
                      : [Theme.of(context).colorScheme.primary.withValues(alpha: .9), Theme.of(context).colorScheme.primary],
                ),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 18,
                      offset: Offset(0, 8))
                ],
              ),
              alignment: Alignment.center,
              child: Text(isActive ? 'SOS Active' : 'SOS',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 12),
          Text(
              isActive
                  ? 'Signal sent to support team.'
                  : 'Tap to notify emergency contacts.',
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.grey.shade200,
      ),
      alignment: Alignment.center,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.map_outlined, size: 48, color: Colors.grey),
          SizedBox(height: 8),
          Text('GPS map preview unavailable in mock mode'),
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({required this.alert});

  final SafetyAlert alert;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = switch (alert.type) {
      SafetyAlertType.weather => Colors.orange,
      SafetyAlertType.route => Colors.blue,
      SafetyAlertType.health => Colors.red,
      SafetyAlertType.general => Colors.green,
    };
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 12,
              height: 12,
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(alert.title,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(alert.message, style: theme.textTheme.bodyMedium),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard(
      {required this.icon,
      required this.label,
      required this.description,
      required this.onTap});

  final IconData icon;
  final String label;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(label,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
