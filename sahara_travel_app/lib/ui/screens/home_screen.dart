import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../models/event.dart';
import '../../models/guide.dart';
import '../../models/trip.dart';
import '../../routes/app_routes.dart';
import '../../ui/widgets/responsive_builder.dart';
import '../../ui/widgets/section_header.dart';

/// Home tab with discover content.
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: _HomeLayout(
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20)),
      tablet: _HomeLayout(
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 32)),
    );
  }
}

class _HomeLayout extends StatelessWidget {
  const _HomeLayout({required this.controller, required this.padding});

  final HomeController controller;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover',
            style: theme.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            tooltip: 'Open chat',
            icon: const CircleAvatar(child: Icon(Icons.chat_bubble_outline)),
            onPressed: () => Get.toNamed(AppRoutes.chat),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: controller.loadContent,
          child: ListView(
            padding: padding,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              _SearchField(onTapFilter: () {}),
              const SizedBox(height: 24),
              const SectionHeader(
                title: 'Recommended trips',
                subtitle: 'Mindful pacing, shared logistics, verified guides',
              ),
              const SizedBox(height: 16),
              _TripCarousel(trips: controller.trips),
              const SizedBox(height: 28),
              const SectionHeader(title: 'Cultural events', subtitle: 'Meet local hosts and storytellers'),
              const SizedBox(height: 16),
              ...controller.events.map((event) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _EventTile(event: event),
                  )),
              const SectionHeader(title: 'Nearby guides', subtitle: 'Travel with trusted locals'),
              const SizedBox(height: 12),
              _GuideStrip(guides: controller.guides),
            ],
          ),
        );
      }),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.onTapFilter});

  final VoidCallback onTapFilter;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search destinations, rituals, or guides',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
            onPressed: onTapFilter, icon: const Icon(Icons.tune_rounded)),
      ),
    );
  }
}

class _TripCarousel extends StatelessWidget {
  const _TripCarousel({required this.trips});

  final List<Trip> trips;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: trips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final trip = trips[index];
          return Container(
            width: 260,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Theme.of(context).colorScheme.primary.withValues(alpha: .85), Theme.of(context).colorScheme.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(26),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, blurRadius: 12, offset: Offset(0, 8))
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(trip.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Text('${trip.location} • ${trip.duration}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white70)),
                const Spacer(),
                Text('MAD ${trip.price.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event});

  final CulturalEvent event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: theme.colorScheme.primary.withValues(alpha: .1),
                  child: const Icon(Icons.local_fire_department,
                      color: Colors.orange),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.title,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      Text('${event.location} • ${event.date}',
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.grey.shade600)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(event.description, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16),
            Row(
              children: [
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_today_outlined),
                    label: const Text('Save date')),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.share))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _GuideStrip extends StatelessWidget {
  const _GuideStrip({required this.guides});

  final List<Guide> guides;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: guides.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final guide = guides[index];
          return Container(
            width: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.grey.shade200),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 24,
                    backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: .1),
                    child: Text(guide.name[0])),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(guide.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis),
                      Text(guide.role,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.grey.shade600),
                          overflow: TextOverflow.ellipsis),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text('${guide.ratingLabel} (${guide.reviewCount})',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
