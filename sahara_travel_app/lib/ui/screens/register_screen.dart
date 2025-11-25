import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/register_controller.dart';
import '../../routes/app_routes.dart';
import '../widgets/responsive_builder.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: _RegisterBody(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        controller: controller,
      ),
      tablet: _RegisterBody(
        padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 48),
        controller: controller,
      ),
    );
  }
}

class _RegisterBody extends StatelessWidget {
  const _RegisterBody({required this.padding, required this.controller});

  final EdgeInsets padding;
  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create account'),
      ),
      body: SingleChildScrollView(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Join Sahara Travel',
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(
              'Sign up as a mindful traveller or a guide stewarding journeys.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: controller.nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Full name',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email address',
                prefixIcon: Icon(Icons.alternate_email_outlined),
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              return DropdownMenu<String>(
                initialSelection: controller.selectedRole.value,
                label: const Text('Role'),
                leadingIcon: const Icon(Icons.badge_outlined),
                onSelected: (value) {
                  if (value != null) {
                    controller.selectedRole.value = value;
                  }
                },
                dropdownMenuEntries: const [
                  DropdownMenuEntry(
                    value: 'user',
                    label: 'Traveller / User',
                  ),
                  DropdownMenuEntry(
                    value: 'guide',
                    label: 'Guide',
                  ),
                ],
              );
            }),
            const SizedBox(height: 16),
            TextField(
              controller: controller.phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone (optional)',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.bioCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Bio (optional)',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.notes_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.confirmPasswordCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm password',
                prefixIcon: Icon(Icons.lock_reset_outlined),
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.register,
                        child: const Text('Create account'),
                      ),
                    ),
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () => Get.offNamed(AppRoutes.login),
                child: const Text('Already have an account? Sign in'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

