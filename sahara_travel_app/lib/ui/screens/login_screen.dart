import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../../routes/app_routes.dart';
import '../../ui/widgets/responsive_builder.dart';

/// Login form with email/password inputs and CTA.
class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: _buildBody(
          context, const EdgeInsets.symmetric(horizontal: 24, vertical: 24)),
      tablet: _buildBody(
          context, const EdgeInsets.symmetric(horizontal: 120, vertical: 48)),
    );
  }

  Widget _buildBody(BuildContext context, EdgeInsets padding) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB2DFDB), Color(0xFF2E7D32)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(Icons.landscape_rounded,
                      size: 86, color: Colors.white),
                ),
              ),
              const SizedBox(height: 32),
              Text('Welcome back 👋',
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                  'Sign in to join mindful desert journeys and connect with local guides.',
                  style: theme.textTheme.bodyMedium),
              const SizedBox(height: 24),
              TextField(
                controller: controller.emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email address',
                  prefixIcon: Icon(Icons.alternate_email_outlined),
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
              const SizedBox(height: 24),
              Obx(() => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: controller.login,
                          child: const Text('Login')),
                    )),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.register),
                    child: const Text('Create new account')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
