import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/group_controller.dart';
import '../../models/group.dart';
import '../widgets/responsive_builder.dart';
import '../widgets/section_header.dart';
import '../widgets/stat_chip.dart';

/// Groups tab showing filters, savings comparison, and group status indicators.
class GroupJoiningScreen extends StatelessWidget {
  const GroupJoiningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GroupController>();
    return ResponsiveBuilder(
      mobile: _Body(
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24)),
      tablet: _Body(
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 32)),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.controller, required this.padding});

  final GroupController controller;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Join a group')),
      body: SingleChildScrollView(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Choose your region',
              subtitle: 'Join travellers heading to similar dunes & routes',
            ),
            const SizedBox(height: 12),
            Obx(() => Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _regions
                      .map(
                        (region) => FilterChip(
                          label: Text(region),
                          selected: controller.selectedRegions.contains(region),
                          onSelected: (_) => controller.toggleRegion(region),
                        ),
                      )
                      .toList(),
                )),
            const SizedBox(height: 24),
            Text('Shared price range (MAD)',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Obx(() => RangeSlider(
                  min: 180,
                  max: 600,
                  divisions: 21,
                  activeColor: theme.colorScheme.primary,
                  values: controller.priceRange.value,
                  labels: RangeLabels(
                    controller.priceRange.value.start.toStringAsFixed(0),
                    controller.priceRange.value.end.toStringAsFixed(0),
                  ),
                  onChanged: controller.updatePrice,
                )),
            const SizedBox(height: 28),
            const SectionHeader(
              title: 'Groups ready to welcome you',
              subtitle: 'Compare savings and departure pace',
            ),
            const SizedBox(height: 12),
            Obx(() {
              final groups = controller.filteredGroups;
              if (groups.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('No matches yet',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Text(
                          'Adjust the filters to explore more shared journeys.',
                          style: theme.textTheme.bodyMedium),
                    ],
                  ),
                );
              }

              return Column(
                children: groups
                    .map((group) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _GroupCard(group: group),
                        ))
                    .toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({required this.group});

  final TravelGroup group;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final savings = group.savings;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(group.name,
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ),
              _StatusChip(status: group.status),
            ],
          ),
          const SizedBox(height: 4),
          Text(group.region,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: Colors.grey.shade600)),
          const SizedBox(height: 12),
          Text(group.highlight, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              StatChip(
                  icon: Icons.calendar_month_outlined, label: group.dateRange),
              StatChip(
                  icon: Icons.group,
                  label: '${group.spotsFilled}/${group.spotsTotal} joined'),
              StatChip(
                  icon: Icons.savings,
                  label: 'Save MAD ${savings.toStringAsFixed(0)}',
                  color: const Color(0xFFFF6F00)),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: group.fillPercent,
            minHeight: 8,
            backgroundColor: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text('Shared price',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: Colors.grey.shade600)),
              const Spacer(),
              Text('MAD ${group.sharedPrice.toStringAsFixed(0)}',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                  child: OutlinedButton(
                      onPressed: () {}, child: const Text('View itinerary'))),
              const SizedBox(width: 12),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text('Join group'))),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final GroupStatus status;

  @override
  Widget build(BuildContext context) {
    final Map<GroupStatus, (String, Color)> meta = {
      GroupStatus.open: ('Open seats', Colors.green.shade600),
      GroupStatus.fillingFast: ('Filling fast', Colors.orange.shade700),
      GroupStatus.lastCall: ('Last call', Colors.red.shade600),
      GroupStatus.departingSoon: ('Departing soon', Colors.red.shade800),
    };

    final entry = meta[status]!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: entry.$2.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt_rounded, size: 16, color: entry.$2),
          const SizedBox(width: 6),
          Text(entry.$1,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: entry.$2, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

const _regions = [
  'Merzouga',
  'Zagora',
  'Erg Chebbi',
  'Douz',
  'Tozeur',
];
