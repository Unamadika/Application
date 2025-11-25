import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/dummy_content.dart';
import '../../routes/app_routes.dart';
import '../../ui/widgets/responsive_builder.dart';
import '../../ui/widgets/section_header.dart';

/// Profile screen showcasing a verified guide with reviews and actions.
class GuideProfileScreen extends StatelessWidget {
  const GuideProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilder(
      mobile: _ProfileLayout(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24)),
      tablet: _ProfileLayout(
          padding: EdgeInsets.symmetric(horizontal: 96, vertical: 40)),
    );
  }
}

class _ProfileLayout extends StatelessWidget {
  const _ProfileLayout({required this.padding});

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final guide = DummyContent.guides.first;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Guide profile')),
      body: SingleChildScrollView(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 46, backgroundColor: theme.colorScheme.primary.withValues(alpha: .1), child: Text(guide.name.substring(0, 1), style: theme.textTheme.headlineMedium)),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(guide.name,
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w700))),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(16)),
                            child: const Row(children: [
                              Icon(Icons.verified,
                                  size: 16, color: Colors.green),
                              SizedBox(width: 4),
                              Text('Verified')
                            ]),
                          )
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(guide.role,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade600)),
                      const SizedBox(height: 8),
                      Row(children: [
                        const Icon(Icons.star_rounded, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                            '${guide.ratingLabel} (${guide.reviewCount} reviews)',
                            style: theme.textTheme.bodyMedium)
                      ])
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            Text('Bio',
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text(
                'Amine crafts restorative journeys across the Sahara with mindful pacing, astronomy walks, and nomad-led rituals.'),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton.icon(
                        onPressed: () => Get.toNamed(AppRoutes.chat),
                        icon: const Icon(Icons.message_outlined),
                        label: const Text('Message'))),
                const SizedBox(width: 12),
                Expanded(
                    child: ElevatedButton.icon(
                        onPressed: () => Get.toNamed(AppRoutes.payment),
                        icon: const Icon(Icons.event_available_outlined),
                        label: const Text('Book now'))),
              ],
            ),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Reviews', subtitle: 'Real travellers sharing their moments'),
            const SizedBox(height: 16),
            ..._reviews
                .map(
                  (review) {
                    final name = review['name'] as String;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  CircleAvatar(child: Text(name[0])),
                                  const SizedBox(width: 12),
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                    Text(name,
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600)),
                                    Text(review['date'],
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                                color: Colors.grey.shade600))
                                  ])),
                              Row(children: [
                                const Icon(Icons.star_rounded,
                                    color: Colors.amber),
                                const SizedBox(width: 4),
                                Text(review['rating'].toString())
                              ])
                            ]),
                            const SizedBox(height: 12),
                            Text(review['comment'],
                                style: theme.textTheme.bodyMedium),
                          ]),
                        ),
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }
}

const List<Map<String, dynamic>> _reviews = [
  {
    'name': 'Saanvi',
    'date': 'Oct 2025',
    'rating': 5,
    'comment': 'Loved the calm pacing. Stargazing with mint tea was unreal.'
  },
  {
    'name': 'Jonas',
    'date': 'Sep 2025',
    'rating': 5,
    'comment': 'Amine kept us safe during a sandstorm and shared desert resilience tips.'
  },
  {
    'name': 'Leila',
    'date': 'Aug 2025',
    'rating': 4.8,
    'comment': 'Transparent prices and thoughtful cultural immersion throughout the journey.'
  },
];
