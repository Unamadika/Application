import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/api_service.dart';

class GuideDashboard extends StatelessWidget {
  const GuideDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final AuthUser? user = Get.arguments as AuthUser?;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Guide Dashboard"),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // WELCOME CARD
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      child: Text(
                        (user?.name.isNotEmpty ?? false)
                            ? user!.name[0].toUpperCase()
                            : "G",
                        style:
                            const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        "Welcome, ${user?.name ?? 'Guide'}!",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            Text("Guide Tools",
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),

            const SizedBox(height: 16),

            // GRID ACTIONS
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              children: [
                _DashboardTile(
                  icon: Icons.tour,
                  label: "My Tours",
                  onTap: () {
                    // TODO: navigate to upcoming tours
                  },
                ),
                _DashboardTile(
                  icon: Icons.group,
                  label: "Bookings",
                  onTap: () {
                    // TODO: navigate to bookings page
                  },
                ),
                _DashboardTile(
                  icon: Icons.message,
                  label: "Messages",
                  onTap: () {
                    // TODO: Go to guide chat
                    // Get.toNamed(AppRoutes.guideChat)
                  },
                ),
                _DashboardTile(
                  icon: Icons.settings,
                  label: "Settings",
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 40),

            // LOGOUT
            Center(
              child: TextButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: "Logout",
                    middleText: "Are you sure you want to logout?",
                    textCancel: "No",
                    textConfirm: "Yes",
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      Get.offAllNamed("/login");
                    },
                  );
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DashboardTile({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: theme.colorScheme.primary),
            const SizedBox(height: 12),
            Text(label,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
git remote -v
